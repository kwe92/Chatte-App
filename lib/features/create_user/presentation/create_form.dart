// ignore_for_file: prefer_final_fields

import 'dart:io';
import 'package:chatapp/app/resources/reusables.dart';
import 'package:chatapp/features/create_user/presentation/user_image_picker.dart';
import 'package:chatapp/app/utils/user_options.dart';
import 'package:chatapp/app/utils/validator.dart';
import 'package:chatapp/shared/widgets/form_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateForm extends StatefulWidget {
  const CreateForm({super.key});

  @override
  State<CreateForm> createState() => _CreateFormState();
}

class _CreateFormState extends State<CreateForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _userExists = false;
  bool _imagePicked = true;
  File? _pickedImage;
  String _errMsg = '';

// Display UI error if image is not picked
  Widget uiErrorImageNotPicked(bool picked) => picked
      ? const SizedBox()
      : const Text(
          'Image required',
          style: TextStyle(color: Colors.red),
        );

  // Display a UI error if the user exists within the database
  Widget uiErrorUserExists(bool exists) => exists
      ? Text(
          _errMsg,
          style: const TextStyle(color: Colors.red),
        )
      : const SizedBox();

// callback for picking an image | UserImagePicker
  void pickedImage(File? pickedimage) => setState(() {
        _pickedImage = pickedimage;
        _imagePicked = true;
      });

//  setState for a picked image | SubmitButton
  void userImagePicked(bool picked) => setState(() {
        _imagePicked = picked;
      });

  // callback for when the async operation is executing | Submit Button
  void isLoading(bool loading) => setState(() {
        _isLoading = loading;
      });

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController userNameController = TextEditingController();

    return Center(
      child: _isLoading
          ? const CircularProgressIndicator.adaptive()
          : Card(
              margin: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      UserImagePicker(callback: pickedImage),
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            // Error message if an image is not picked
                            uiErrorImageNotPicked(_imagePicked),
                            // Error message if the user email exists
                            uiErrorUserExists(_userExists),
                            FormFields(
                              userNameController: userNameController,
                              passwordController: passwordController,
                              emailController: emailController,
                              isLogin: true,
                            ),
                            gaph16,
                            // Submit button component to create a new user
                            // SubmitButton(
                            //   formKey: _formKey,
                            //   userNameController: userNameController,
                            //   emailController: emailController,
                            //   passwordController: passwordController,
                            //   imagefile: _pickedImage,
                            //   userExistsCallback: existingUser,
                            //   isLoadingCallback: isLoading,
                            //   pickedImageCallBack: userImagePicked,
                            // ),
                            SizedBox(
                                width: 400,
                                //TODO: This button needs to be its own module
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_pickedImage == null) {
                                      // Show ui error for image and validators
                                      userImagePicked(false);
                                      Validator.trySubmit(_formKey);
                                      return;
                                    }
                                    final valid = Validator.trySubmit(_formKey);
                                    // Validation successful create a user
                                    if (valid) {
                                      final colRef = FirebaseFirestore.instance.collection('users');
                                      try {
                                        isLoading(true);
                                        await UserOptions.createUser(
                                            userNameController: userNameController,
                                            passwordController: passwordController,
                                            emailController: emailController,
                                            file: _pickedImage,
                                            colRef: colRef);

                                        // ignore: use_build_context_synchronously
                                        Navigator.pushReplacementNamed(context, '/');
                                      } catch (e) {
                                        setState(() {
                                          _userExists = true;
                                          _errMsg = e.toString();
                                          _isLoading = false;
                                        });
                                        debugPrint(e.toString());
                                      }
                                    } else {
                                      return;
                                    }
                                  },
                                  child: const Text('Submit'),
                                )),
                            // Navigate to auth page`
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(context, '/');
                                },
                                child: const Text('I already have an account'))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
