import 'package:chatapp/shared/models/base_user.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/shared/services/services.dart';

class AuthViewModel extends ChangeNotifier {
  AuthViewModel();

  // TODO: use mutable variables instead of controller text
  //The form key is used to validate the form
  final formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

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
    userNameController.clear();
    notifyListeners();
  }
}
