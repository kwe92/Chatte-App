import 'dart:io';

//TODO: Error message not showing for existing users
import 'package:chatapp/src/utils/user_options.dart';
import 'package:chatapp/src/utils/validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

typedef IsLoadingCallback = void Function(bool loading);
typedef UserExsistsCallback = void Function(
    {required bool userExist, required bool isLoading});

class SubmitButton extends StatelessWidget {
  const SubmitButton(
      {required this.formKey,
      required this.userNameController,
      required this.emailController,
      required this.passwordController,
      required this.imagefile,
      required this.userExistsCallback,
      required this.isLoadingCallback,
      super.key});

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController userNameController;
  final IsLoadingCallback isLoadingCallback;
  final UserExsistsCallback userExistsCallback;
  final File? imagefile;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) => SizedBox(
      width: 400,
      //TODO: This button needs to be its own module
      child: ElevatedButton(
        onPressed: () async {
          final valid = Validator.trySubmit(formKey);
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
              // Navigator.pushReplacementNamed(context, '/');
            } catch (e) {
              userExistsCallback(userExist: true, isLoading: false);
              // setState(() {
              //   _userExists = true;
              //   _errMsg = e.toString();
              //   _isLoading = false;
              // });
              // debugPrint(e.toString());
            }
          } else {
            return;
          }
        },
        child: const Text('Submit'),
      ));
}
