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
import 'package:chatapp/src/features/authentication/presentation/login_button.dart';
import 'package:chatapp/src/widgets/form_fields.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({required this.onPressed, super.key});
  final void Function() onPressed;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _userNotFound = false;
  bool _userFound = false;
  // FocusScope.of(context).unfocus();

// callback to handle user not found
  void _isValid(bool valid) => setState(() {
        _userNotFound = valid;
      });

  void _successfulLogin(bool successful) => setState(() {
        _userFound = successful;
      });

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController userNameController = TextEditingController();
    return Center(
      child: _userFound
          ? const CircularProgressIndicator.adaptive()
          : Card(
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
                        LoginButton(
                          formKey: _formKey,
                          userNameController: userNameController,
                          emailController: emailController,
                          passwordController: passwordController,
                          userNotFoundCallback: _isValid,
                          successCallback: _successfulLogin,
                        ),
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
