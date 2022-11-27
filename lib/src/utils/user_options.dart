import 'dart:io';

import 'package:chatapp/src/features/create_user/domain/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UserOptions {
  const UserOptions();

  static Future<void> createUser(
      {required TextEditingController userNameController,
      required TextEditingController passwordController,
      required TextEditingController emailController,
      required File? file,
      required CollectionReference<Map<String, dynamic>> colRef}) async {
    final userCredentials = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
    final UserModel user = UserModel(
        id: userCredentials.user!.uid,
        username: userNameController.text,
        password: passwordController.text,
        email: emailController.text);
    final json = user.toJSON();
    await colRef.doc(user.id).set(json);
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('user_images')
        .child('${user.id}.jpg');
    await storageRef.putFile(file!);
  }
}
