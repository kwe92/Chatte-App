import 'dart:io';

import 'package:chatapp/app/general/constants.dart';
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
  void setPickedImage(File? pickedimage) {
    _pickedImage = pickedimage;
    _isImagePicked = true;
    notifyListeners();
  }

//  setState for a picked image | SubmitButton
  void setIsImagePicked(bool picked) {
    _isImagePicked = picked;
    notifyListeners();
  }

  void setIsChecked(bool? checked) {
    if (checked != null) {
      _isChecked = checked;
    }
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

  setCurrentUser(UserCredential? userCredential) async {
    if (userCredential != null) {
      _currentUser = await userService.getCurrentUser(
        CollectionPath.users.path,
        userCredential.user!.uid,
      );

      debugPrint('currentUser: $_currentUser');
    } else {
      throw Exception('there was an issue during account creation.');
    }
  }

  Future<void> pickImage() async {
    final (imageFile, didPickImage, error) = await runBusyFuture<(File?, bool, String?)>(() => imagePickerService.pickImage());

    if (error != null) {
      toastService.showSnackBar(ToastServiceErrorMessage.imageError);
    }

    if (didPickImage && imageFile != null) {
      setPickedImage(imageFile);
    }
  }

  Future<abs.User?> createUserInFirebase() async {
    try {
      doesUserNameExist();

      final colRef = firestoreService.instance.collection(CollectionPath.users.path);

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

      debugPrint("_currentUser: $_currentUser");

      return _currentUser;
    } catch (exception) {
      debugPrint(exception.toString());
      setBusy(false);
      return null;
    }
  }

  void doesUserNameExist() {
    final bool userNameExists = userService.userNames.contains(_username.toLowerCase());

    debugPrint("userService.userNames: ${userService.userNames}");

    debugPrint('userNameExists: $userNameExists');

    if (userNameExists) {
      toastService.showSnackBar(ToastServiceErrorMessage.unavailableUserNameError);
      throw Exception('user name taken.');
    }
  }

  void checkError(String? error) {
    if (error != null) {
      if (error.toString().contains('in use')) {
        toastService.showSnackBar(ToastServiceErrorMessage.unavailableEmailError);
        throw Exception('email address in use.');
      }
      toastService.showSnackBar(ToastServiceErrorMessage.accountCreationError);
      throw Exception('there was an issue during account creation.');
    }
  }

  bool isReadyToSignUp() {
    if (pickedImage == null) {
      setIsImagePicked(false);
      return false;
    }

    if (!isMatchingPassword) {
      toastService.showSnackBar(ToastServiceErrorMessage.passwordMismatchError);
      return false;
    }

    if (!isChecked) {
      toastService.showSnackBar(ToastServiceErrorMessage.termsAndConditionsError);

      return false;
    }

    if (!ready) {
      toastService.showSnackBar(ToastServiceErrorMessage.fillAllRequiredFieldsError);
      return false;
    }

    return true;
  }
}
