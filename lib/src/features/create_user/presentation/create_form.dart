// ignore_for_file: prefer_final_fields

import 'dart:io';
import 'package:chatapp/src/constants/source_of_truth.dart';
import 'package:chatapp/src/features/create_user/presentation/submit_button.dart';
import 'package:chatapp/src/features/create_user/presentation/user_image_picker.dart';
import 'package:chatapp/src/utils/user_options.dart';
import 'package:chatapp/src/utils/validator.dart';
import 'package:chatapp/src/widgets/form_fields.dart';
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
  File? _pickedImage;
  String _errMsg = '';

// callback for picking an image
  void pickedImage(File? pickedimage) => setState(() {
        _pickedImage = pickedimage;
      });

  void existingUser({required bool userExist, required bool isLoading}) {
    setState(() {
      _userExists = true;
      // _errMsg = e.toString();
      _isLoading = false;
    });
    // debugPrint(e.toString());
  }

  void isLoading(bool loading) => setState(() {
        _isLoading = true;
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
                            _userExists
                                ? Text(
                                    _errMsg,
                                    style: const TextStyle(color: Colors.red),
                                  )
                                : const SizedBox(),
                            FormFields(
                              userNameController: userNameController,
                              passwordController: passwordController,
                              emailController: emailController,
                              isLogin: true,
                            ),
                            gaph16,
                            // SubmitButton(
                            //     formKey: _formKey,
                            //     userNameController: userNameController,
                            //     emailController: emailController,
                            //     passwordController: passwordController,
                            //     imagefile: _pickedImage,
                            //     userExistsCallback: existingUser,
                            //     isLoadingCallback: isLoading),
                            SizedBox(
                              width: 400,
                              //TODO: This button needs to be its own module
                              child: ElevatedButton(
                                onPressed: () async {
                                  final valid = Validator.trySubmit(_formKey);
                                  if (valid) {
                                    final colRef = FirebaseFirestore.instance
                                        .collection('users');
                                    try {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      await UserOptions.createUser(
                                          userNameController:
                                              userNameController,
                                          passwordController:
                                              passwordController,
                                          emailController: emailController,
                                          file: _pickedImage,
                                          colRef: colRef);

                                      // ignore: use_build_context_synchronously
                                      Navigator.pushReplacementNamed(
                                          context, '/');
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
                              ),
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
