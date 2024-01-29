import 'package:flutter/material.dart';

class Validator {
  Validator._();
  static bool trySubmit(GlobalKey<FormState> key) => key.currentState?.validate() ?? false;
}
