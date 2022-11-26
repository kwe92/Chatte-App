// class AuthForm stfl
// widget tree
//  - Center
//    - Card with margin
//      - SingChildScrollView
//        - Padding
//          - Form
//            - Column maxAlign.min (to take up as little space as needed) collect email, username and [password]
//                - <Widget>[TextFormField(keyboardType, decoration, labelText, labelStyle)] password TextField should have obscure true
//                - Button to login
//                - Button to create account | Try FlatButton first
// nl

import 'package:chatapp/src/constants/source_of_truth.dart';
import 'package:chatapp/src/features/authentication/login_button.dart';
import 'package:chatapp/src/features/create_user/domain/user_model.dart';
import 'package:chatapp/src/utils/validator.dart';
import 'package:chatapp/src/widgets/form_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//TODO: Add image Picker functionality

class AuthForm extends StatefulWidget {
  const AuthForm({required this.onPressed, super.key});
  final void Function() onPressed;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

// retrieves all users
Future<DocumentSnapshot<Map<String, dynamic>>> _getUser(
        {required collection, required userid}) async =>
    await FirebaseFirestore.instance.collection(collection).doc(userid).get();

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _userNotFound = false;
  // FocusScope.of(context).unfocus();

  void _isValid(bool valid) => setState(() {
        _userNotFound = valid;
      });

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController userNameController = TextEditingController();
    return Center(
      child: Card(
        margin: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _userNotFound
                      ? const Text(
                          'Wrong username or password',
                          style: TextStyle(color: Colors.red),
                        )
                      : const SizedBox(),
                  FormFields(
                      userNameController: userNameController,
                      passwordController: passwordController,
                      emailController: emailController),
                  gaph16,
                  SizedBox(
                    width: 400,
                    // Login Button
                    child: LoginButton(
                        formKey: _formKey,
                        emailController: emailController,
                        passwordController: passwordController,
                        callback: _isValid),
                  ),
                  // gaph8,
                  TextButton(
                      onPressed: () {
                        widget.onPressed();
                      },
                      child: const Text('Create Account'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
