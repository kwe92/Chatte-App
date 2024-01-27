import 'dart:io';

//TODO: Error message not showing for existing users
//TODO: Show error message if there is no image selected

import 'package:chatapp/app/utils/user_options.dart';
import 'package:chatapp/app/utils/validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

typedef IsLoadingCallback = void Function(bool loading);
typedef UserExsistsCallback = void Function({required bool userExist, required bool isLoading, required String errorMsg});

typedef PickedImageCallBack = void Function(bool picked);

class SubmitButton extends StatelessWidget {
  const SubmitButton(
      {required this.formKey,
      required this.userNameController,
      required this.emailController,
      required this.passwordController,
      required this.imagefile,
      required this.userExistsCallback,
      required this.isLoadingCallback,
      required this.pickedImageCallBack,
      super.key});

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController userNameController;
  final IsLoadingCallback isLoadingCallback;
  final UserExsistsCallback userExistsCallback;
  final PickedImageCallBack pickedImageCallBack;
  final File? imagefile;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 400,
        child: ElevatedButton(
          onPressed: () async {
            final valid = Validator.trySubmit(formKey);
            if (imagefile == null) {
              pickedImageCallBack(false);
              return;
            }
            if (valid) {
              final colRef = FirebaseFirestore.instance.collection('users');
              try {
                isLoadingCallback(true);
                await UserOptions.createUser(
                    userNameController: userNameController,
                    passwordController: passwordController,
                    emailController: emailController,
                    file: imagefile,
                    colRef: colRef);

                // ignore: use_build_context_synchronously
                Navigator.pushReplacementNamed(context, '/');
              } catch (e) {
                print(e);
                userExistsCallback(userExist: true, isLoading: false, errorMsg: e.toString());
              }
            } else {
              return;
            }
          },
          child: const Text('Submit'),
        ),
      );
}
