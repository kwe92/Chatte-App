import 'package:chatapp/app/general/constants.dart';
import 'package:chatapp/shared/models/user.dart';
import 'package:chatapp/shared/utils/classes/extended_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/shared/services/services.dart';

class SignInViewModel extends ExtendedChangeNotifier {
  SignInViewModel();

  final formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _switchState = false;

  String _email = '';

  String _password = '';

  bool get switchState => _switchState;

  String get email => _email;

  String get password => _password;

  void setSwitchState(bool isSwitchedOn) {
    _switchState = isSwitchedOn;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email.trim().toLowerCase();
    debugPrint(_email);
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password.trim();
    debugPrint(_password);

    notifyListeners();
  }

  Future<User?> signInWithEmailAndPassword() async {
    setBusy(true);
    var error = await firebaseService.signInWithEmailAndPassword(email, password);

    if (error == null) {
      // currently logged in user data
      final currentUser = await createCurrentUser();
      setBusy(false);

      return currentUser;
    }

    setBusy(false);

    toastService.showSnackBar(ToastServiceErrorMessage.failedLoginError);

    return null;
  }

  Future<User> createCurrentUser() async {
    final String userid = firebaseService.currentUser!.uid;

    // Currently logged in user data
    final currentUser = await userService.getCurrentUser(CollectionPath.users.path, userid);

    return currentUser;
  }

  void clearData() {
    emailController.clear();
    passwordController.clear();
    setEmail('');
    setPassword('');
    notifyListeners();
  }
}
