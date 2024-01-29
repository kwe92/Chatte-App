import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  //The form key is used to validate the form
  final formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  bool _userNotFound = false;

  bool _userFound = false;

  bool get userNotFound => _userNotFound;

  bool get userFound => _userFound;

// callback to handle user not found
  void isValid(bool valid) {
    _userNotFound = valid;
    notifyListeners();
  }

// callback to handle successful login
  void successfulLogin(bool successful) {
    _userFound = successful;
    notifyListeners();
  }
}
