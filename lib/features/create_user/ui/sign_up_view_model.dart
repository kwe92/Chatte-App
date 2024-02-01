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

  File? _pickedImage;

  bool get isImagePicked => _isImagePicked;

  bool get isChecked => _isChecked;

  File? get pickedImage => _pickedImage;

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

  Future<void> pickImage() async {
    final File? result = await imagePickerService.pickImage();
    _setPickedImage(result);
  }

  Future<(BaseUser?, String?)> createUserInFirebase() async {
    BaseUser? currentUser;

    final colRef = firestoreService.instance.collection('users');

    setBusy(true);

    final (userCredential, error) = await userService.createUserInFirebase(
      userName: userNameController.text,
      password: passwordController.text,
      email: emailController.text,
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
