import 'dart:io';

import 'package:chatapp/shared/models/base_user.dart';
import 'package:chatapp/shared/services/services.dart';
import 'package:chatapp/shared/utils/classes/extended_change_notifier.dart';
import 'package:flutter/material.dart';

class SignUpViewModel extends ExtendedChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

// controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  bool _isImagePicked = true;

  bool _isChecked = false;

  String _email = '';

  String _username = '';

  String _password = '';

  String _confirmPassword = '';

  File? _pickedImage;

  bool get isImagePicked => _isImagePicked;

  bool get isChecked => _isChecked;

  File? get pickedImage => _pickedImage;

  bool get ready => _email.isNotEmpty && _username.isNotEmpty && _password.isNotEmpty;

  bool get isMatchingPassword => _password == _confirmPassword;

  // callback for picking an image | UserImagePicker
  void _setPickedImage(File? pickedimage) {
    _pickedImage = pickedimage;
    _isImagePicked = true;
    notifyListeners();
  }

//  setState for a picked image | SubmitButton
  void setIsImagePicked(bool picked) {
    _isImagePicked = picked;
    notifyListeners();
  }

  void setIsChecked(checked) {
    _isChecked = checked;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email.trim().toLowerCase();
    debugPrint(_email);
    notifyListeners();
  }

  void setUsername(String username) {
    _username = username.trim();
    debugPrint(_username);

    notifyListeners();
  }

  void setPassword(String password) {
    _password = password.trim();
    debugPrint(_password);

    notifyListeners();
  }

  void setConfirmPassword(String confirmedPassword) {
    _confirmPassword = confirmedPassword.trim();
    debugPrint(_confirmPassword);

    notifyListeners();
  }

  Future<void> pickImage() async {
    final File? result = await runBusyFuture<File?>(() => imagePickerService.pickImage());

    _setPickedImage(result);
  }

  Future<(BaseUser?, String?)> createUserInFirebase() async {
    BaseUser? currentUser;

    final colRef = firestoreService.instance.collection('users');

    setBusy(true);

    final (userCredential, error) = await userService.createUserInFirebase(
      userName: _username,
      password: _password,
      email: _email,
      file: pickedImage,
      colRef: colRef,
    );

    if (userCredential != null) {
      currentUser = await userService.getCurrentUser(
        'users',
        userCredential.user!.uid,
      );
    }

    setBusy(false);

    return (currentUser, error);
  }
}
