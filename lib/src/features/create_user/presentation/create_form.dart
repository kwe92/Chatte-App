// ignore_for_file: prefer_final_fields

import 'dart:io';
import 'package:chatapp/src/constants/source_of_truth.dart';
import 'package:chatapp/src/features/create_user/presentation/submit_button.dart';
import 'package:chatapp/src/features/create_user/presentation/user_image_picker.dart';
import 'package:chatapp/src/widgets/form_fields.dart';
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

  Widget uiErrorImageNotPicked(bool picked) => picked
      ? const SizedBox()
      : const Text(
          'Image required',
          style: TextStyle(color: Colors.red),
        );

  Widget uiErrorUserExists(bool exists) => exists
      ? Text(
          _errMsg,
          style: const TextStyle(color: Colors.red),
        )
      : const SizedBox();

// callback for picking an image
  void pickedImage(File? pickedimage) => setState(() {
        _pickedImage = pickedimage;
      });

  // callback for submit button
  void existingUser(
      {required bool userExist,
      required bool isLoading,
      required String errorMsg}) {
    setState(() {
      _userExists = userExist;
      _errMsg = errorMsg.toString();
      _isLoading = isLoading;
    });
  }

  // callback for submit button
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
                      //TODO: Change image file size
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
                            SubmitButton(
                              formKey: _formKey,
                              userNameController: userNameController,
                              emailController: emailController,
                              passwordController: passwordController,
                              imagefile: _pickedImage,
                              userExistsCallback: existingUser,
                              isLoadingCallback: isLoading,
                            ),
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
