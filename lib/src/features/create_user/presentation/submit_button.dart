import 'dart:io';

//TODO: Error message not showing for existing users
//TODO: Show error message if there is no image selected

import 'package:chatapp/src/utils/user_options.dart';
import 'package:chatapp/src/utils/validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

typedef IsLoadingCallback = void Function(bool loading);
typedef UserExsistsCallback = void Function(
    {required bool userExist,
    required bool isLoading,
    required String errorMsg});

typedef PickedImageCallBack = void Function(bool picked);

class SubmitButton extends StatefulWidget {
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
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  Future<void> myAsyncMethod(
      BuildContext context, VoidCallback onSuccess) async {
    final colRef = FirebaseFirestore.instance.collection('users');
    await UserOptions.createUser(
        userNameController: widget.userNameController,
        passwordController: widget.passwordController,
        emailController: widget.emailController,
        file: widget.imagefile,
        colRef: colRef);
    onSuccess.call();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 400,
        child: ElevatedButton(
          onPressed: () async {
            final valid = Validator.trySubmit(widget.formKey);
            if (widget.imagefile == null) {
              widget.pickedImageCallBack(false);
              return;
            }
            if (valid) {
              final colRef = FirebaseFirestore.instance.collection('users');
              try {
                widget.isLoadingCallback(true);

                myAsyncMethod(context, () {
                  if (!mounted) {
                    return;
                  }
                  Navigator.pushReplacementNamed(context, '/');
                });

                await UserOptions.createUser(
                    userNameController: widget.userNameController,
                    passwordController: widget.passwordController,
                    emailController: widget.emailController,
                    file: widget.imagefile,
                    colRef: colRef);

                // ignore: use_build_context_synchronously
                Navigator.pushReplacementNamed(context, '/');
              } catch (e) {
                debugPrint(e.toString());
                widget.userExistsCallback(
                    userExist: true, isLoading: false, errorMsg: e.toString());
              }
            } else {
              return;
            }
          },
          child: const Text('Submit'),
        ),
      );
}
