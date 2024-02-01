import 'package:flutter/material.dart';

class FormFieldParameters {
  // controllers
  final TextEditingController? emailController;
  final TextEditingController? userNameController;
  final TextEditingController? passwordController;

  // onChanged methods
  final void Function(String)? setEmail;
  final void Function(String)? setUsername;
  final void Function(String)? setPassword;

  const FormFieldParameters({
    this.emailController,
    this.userNameController,
    this.passwordController,
    this.setEmail,
    this.setUsername,
    this.setPassword,
  });
}
