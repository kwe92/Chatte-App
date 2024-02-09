import 'dart:async';
import 'dart:io';

import 'package:chatapp/app/general/constants.dart';
import 'package:chatapp/shared/models/user.dart' as abs;
import 'package:chatapp/shared/models/user_model.dart';
import 'package:chatapp/shared/services/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserService extends ChangeNotifier {
  List<dynamic> _userNames = [];

  // TODO: should be cast to a list of strings
  List<dynamic> get userNames => _userNames;

  late StreamSubscription _usersStreamSub;

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

      final abs.User user = UserModel(
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
  Future<abs.User> getCurrentUser(String collectionPath, String userid) async {
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
    abs.User user,
  ) async {
    final json = user.toJSON();

    await colRef.doc(user.id).set(json);
  }

  void userNameListener() {
    final usersStream = firestoreService.getAllDocuments(collectionPath: CollectionPath.users.path);

    _usersStreamSub = usersStream.listen(
      (users) {
        _userNames = users.map((user) => user['username'].toLowerCase()).toList();

        debugPrint('userNames: $_userNames');
        notifyListeners();
      },
    );

    notifyListeners();
  }

  Future<void> closeUserNameListener() async {
    await _usersStreamSub.cancel();
    debugPrint('stream subscription in getUserNames closed successfully!');
  }
}
