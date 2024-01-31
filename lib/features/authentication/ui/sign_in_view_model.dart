import 'package:chatapp/shared/models/base_user.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/shared/services/services.dart';

class SignInViewModel extends ChangeNotifier {
  SignInViewModel();

  final formKey = GlobalKey<FormState>();

  bool _switchState = false;

  bool get switchState => _switchState;

  // Controllers
  // TODO: use mutable variables instead of controller text
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void setSwitchState(bool isSwitchedOn) {
    _switchState = isSwitchedOn;

    notifyListeners();
  }

  Future<String?> signInWithEmailAndPassword() async {
    return await firebaseService.signInWithEmailAndPassword(emailController.text, passwordController.text);
  }

  // TODO: maybe temporally coupled with signInWithEmailAndPassword | fix it at some point
  Future<BaseUser> createCurrentUser() async {
    final String userid = firebaseService.currentUser!.uid;

    // Currently logged in user data
    final currentUser = await userService.getCurrentUser('users', userid);

    return currentUser;
  }

  void clearControllers() {
    emailController.clear();
    passwordController.clear();
    notifyListeners();
  }
}
