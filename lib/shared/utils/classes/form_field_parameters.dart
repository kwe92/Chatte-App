import 'package:flutter/material.dart';

class FormFieldParameters {
  // controllers
  final TextEditingController? emailController;
  final TextEditingController? userNameController;
  final TextEditingController? passwordController;
  final TextEditingController? conFirmPasswordController;

  // onChanged methods
  final void Function(String)? setEmail;
  final void Function(String)? setUsername;
  final void Function(String)? setPassword;
  final void Function(String)? setConfirmPassword;

  const FormFieldParameters({
    this.emailController,
    this.userNameController,
    this.passwordController,
    this.conFirmPasswordController,
    this.setEmail,
    this.setUsername,
    this.setPassword,
    this.setConfirmPassword,
  });
}
