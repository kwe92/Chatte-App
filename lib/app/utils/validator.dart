import 'package:flutter/material.dart';

class Validator {
  static bool trySubmit(GlobalKey<FormState> key) {
    return key.currentState!.validate();
  }
}
