import 'dart:io';

import 'package:chatapp/shared/models/base_user.dart';
import 'package:chatapp/shared/models/user.dart';
import 'package:chatapp/shared/services/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// TODO: need to add get user method

class UserService {
  static Future<void> createUserInFirebase({
    required String userName,
    required String password,
    required String email,
    required File file,
    required CollectionReference<Map<String, dynamic>> colRef,
  }) async {
    final userCredentials = await firebaseInstanceService.authInstance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final userid = userCredentials.user!.uid;

    // TODO: should be its own function
    final storageRef = firebaseInstanceService.storageInstance.ref().child('user_images').child('$userid.jpg');

    await storageRef.putFile(file);

    final BaseUser user = UserModel(
      id: userid,
      username: userName,
      password: password,
      email: email,
      url: await storageRef.getDownloadURL(),
    );
    final json = user.toJSON();
    await colRef.doc(user.id).set(json);
  }
}
