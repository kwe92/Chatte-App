import 'package:flutter/material.dart';

class PasswordVisibilityController extends ChangeNotifier {
  bool _isObscured = true;

  bool get isObscured => _isObscured;

  void setIsObscured() {
    _isObscured = !_isObscured;
    notifyListeners();
  }
}
