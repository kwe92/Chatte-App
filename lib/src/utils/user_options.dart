import 'dart:io';

import 'package:chatapp/src/features/chat/domain/message_model.dart';
import 'package:chatapp/src/features/create_user/domain/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UserOptions {
  const UserOptions();

  // Create a User
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

// Retrieve a single user by id
  static Future<DocumentSnapshot<Map<String, dynamic>>> getUser(
          {required collection, required userid}) async =>
      await FirebaseFirestore.instance.collection(collection).doc(userid).get();

// Delete a message given the currently logged in user
  static Future<void> deleteMessage(
      {required String id, required String path}) async {
    final docUsers = FirebaseFirestore.instance.collection(path).doc(id);
    await docUsers.delete();
  }

  // Send a message by current user
  static void sendMessage(UserModel user, String text, String path) {
    final colRef = FirebaseFirestore.instance.collection(path);
    final textID = colRef.doc().id;
    MessageModel newMessage = MessageModel(
        userid: user.id,
        username: user.username,
        userImageUrl: user.url,
        textID: textID,
        text: text);
    colRef.doc(textID).set(newMessage.toJSON());
  }
}
