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
    final userid = userCredentials.user!.uid;

    final storageRef = FirebaseStorage.instance
        .ref()
        .child('user_images')
        .child('$userid.jpg');
    await storageRef.putFile(file!);
    final UserModel user = UserModel(
        id: userid,
        username: userNameController.text,
        password: passwordController.text,
        email: emailController.text,
        url: await storageRef.getDownloadURL());
    final json = user.toJSON();
    await colRef.doc(user.id).set(json);
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>> getUser(
          {required collection, required userid}) async =>
      await FirebaseFirestore.instance.collection(collection).doc(userid).get();
}
