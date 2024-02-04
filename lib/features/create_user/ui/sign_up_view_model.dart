import 'dart:io';

import 'package:chatapp/shared/models/user.dart' as abs;
import 'package:chatapp/shared/services/services.dart';
import 'package:chatapp/shared/utils/classes/extended_change_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  abs.User? _currentUser;

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
    final (imageFile, didPickImage, error) = await runBusyFuture<(File?, bool, String?)>(() => imagePickerService.pickImage());

    if (error != null) {
      toastService.showSnackBar("image maybe corrupted, please try another image.");
    }

    if (didPickImage && imageFile != null) {
      _setPickedImage(imageFile);
    }
  }

  Future<abs.User?> createUserInFirebase() async {
    try {
      doesUserNameExist();

      final colRef = firestoreService.instance.collection('users');

      setBusy(true);

      final (userCredential, error) = await userService.createUserInFirebase(
        userName: _username,
        password: _password,
        email: _email,
        file: pickedImage,
        colRef: colRef,
      );

      checkError(error);

      await setCurrentUser(userCredential);

      await userService.closeUserNameListener();

      setBusy(false);

      return _currentUser;
    } catch (exception) {
      debugPrint(exception.toString());
      setBusy(false);
      return null;
    }
  }

  void doesUserNameExist() {
    final bool userNameExists = userService.userNames.contains(_username.toLowerCase());

    debugPrint('userNameExists: $userNameExists');

    if (userNameExists) {
      toastService.showSnackBar('user name taken.');
      throw Exception('user name taken.');
    }
  }

  setCurrentUser(UserCredential? userCredential) async {
    if (userCredential != null) {
      _currentUser = await userService.getCurrentUser(
        'users',
        userCredential.user!.uid,
      );

      debugPrint('currentUser: $_currentUser');
    } else {
      throw Exception('there was an issue during account creation.');
    }
  }

  void checkError(String? error) {
    if (error != null) {
      if (error.toString().contains('in use')) {
        toastService.showSnackBar('email address in use.');
        throw Exception('email address in use.');
      }
      toastService.showSnackBar('there was an issue creating your account.');
      throw Exception('there was an issue during account creation.');
    }
  }

  bool isReadyToSignUp() {
    if (pickedImage == null) {
      setIsImagePicked(false);
      return false;
    }

    if (!isMatchingPassword) {
      toastService.showSnackBar('passwords do not match');
      return false;
    }

    if (!isChecked) {
      toastService.showSnackBar('accept terms and conditions before proceeding');

      return false;
    }

    if (!ready) {
      toastService.showSnackBar('please fill out all required fields.');
    }

    return true;
  }
}
