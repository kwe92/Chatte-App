import 'package:flutter/material.dart';

class FormFields extends StatelessWidget {
  const FormFields(
      {required this.userNameController,
      required this.passwordController,
      required this.emailController,
      this.isLogin = false,
      super.key});
  // a boolean variable that allows this component to be used for both Auth and Create Screen
  final bool isLogin;
  final TextEditingController userNameController;
  final TextEditingController passwordController;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      // Email field
      TextFormField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(labelText: 'e-mail'),
        // Email field validator
        validator: isLogin
            ? (value) {
                if (value == null) {
                  return 'Email can not be empty.';
                }
                if (value.isEmpty ||
                    !value.contains('@') ||
                    value.contains(' ')) {
                  return """
Email can not be empty
or contain spaces 
and must contain @.""";
                }
                return null;
              }
            : null,
      ),
      // Username field
      isLogin
          ? TextFormField(
              controller: userNameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: 'username'),
              // Username field validator
              validator: (value) {
                if (value!.length < 4) {
                  return 'Username must be at least 4 characters.';
                }
                if (value.contains(RegExp(r'[^A-Za-z0-9]'))) {
                  return 'Username can not contain special characters or spaces.';
                }
                return null;
              },
            )
          : const SizedBox(),
      // Password field
      TextFormField(
        controller: passwordController,
        obscureText: true,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(labelText: 'password'),
        // Password field validator
        validator: isLogin
            ? (value) {
                if (value!.length < 7) {
                  return 'Password must be at least 7 characters long.';
                }
                if (!value.contains(RegExp(
                    r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"))) {
                  return r"""

Password Requirements:

  At least one:
    - digit
    - lowercase character
    - least uppercase character
    - least special character
  
  - least 8 - 32 characters in length.

""";
                }
                return null;
              }
            : null,
      )
    ]);
  }
}
