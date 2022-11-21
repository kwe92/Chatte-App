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
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key, required this.onPressed});
  final void Function() onPressed;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: 'e-mail'),
                  ),
                  TextFormField(
                    controller: userNameController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(labelText: 'username'),
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(labelText: 'password'),
                  ),
                  gaph16,
                  SizedBox(
                    width: 400,
                    child: ElevatedButton(
                      onPressed: () {
                        debugPrint(userNameController.text);
                      },
                      child: const Text('Login'),
                    ),
                  ),
                  // gaph8,
                  TextButton(
                      onPressed: () {
                        widget.onPressed();
                      },
                      child: const Text('Create Account.'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
