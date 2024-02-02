import 'dart:io';

import 'package:chatapp/shared/models/base_user.dart';
import 'package:chatapp/shared/models/user.dart';
import 'package:chatapp/shared/services/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  Future<(UserCredential?, String?)> createUserInFirebase({
    required String userName,
    required String password,
    required String email,
    required File? file,
    required CollectionReference<Map<String, dynamic>> colRef,
  }) async {
    final (userCredentials, error) = await firebaseService.createUserWithEmailAndPassword(
      email,
      password,
    );

    if (userCredentials != null) {
      final userid = userCredentials.user!.uid;

      final storageRef = await firebaseService.uploadImageToStorage(userid, file);

      final AbstractUser user = UserModel(
        id: userid,
        username: userName,
        password: password,
        email: email,
        url: await storageRef.getDownloadURL(),
      );

      await overrideUserData(colRef, user);

      return (userCredentials, null);
    }
    return (null, error);
  }

  // Retrieve a single user by id
  Future<AbstractUser> getCurrentUser(String collectionPath, String userid) async {
    // Get user by id
    final docSnapshot = await firebaseService.getUser(collectionPath: collectionPath, userid: userid);

    // Currently logged in user data
    final currentUser = UserModel.fromJSON(
      docSnapshot.data(),
    );

    return currentUser;
  }

  Future<void> overrideUserData(
    CollectionReference<Map<String, dynamic>> colRef,
    AbstractUser user,
  ) async {
    final json = user.toJSON();

    await colRef.doc(user.id).set(json);
  }
}
