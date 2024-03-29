import 'dart:io';

import 'package:chatapp/app/general/constants.dart';
import 'package:chatapp/shared/models/message.dart';
import 'package:chatapp/shared/models/user_message.dart';
import 'package:chatapp/shared/models/user.dart' as abs;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

// TODO: add better comments

/// API used to interact with [FirebaseAuth], [FirebaseStorage], and [FirebaseFirestore].
class FirebaseService extends ChangeNotifier {
  bool _isLoggedIn = false;

  // static final _firebaseServiceInstance = FirebaseService._internal();

  FirebaseAuth _authInstance;
  FirebaseStorage _storageInstance;
  FirebaseFirestore _firestoreInstance;

  FirebaseStorage get storageInstance => _storageInstance;

  User? get currentUser => _authInstance.currentUser;
  bool get isLoggedIn => _isLoggedIn;

  factory FirebaseService({
    required FirebaseAuth authInstance,
    required FirebaseStorage storageInstance,
    required FirebaseFirestore firestoreInstance,
  }) =>
      FirebaseService._internal(
        authInstance,
        storageInstance,
        firestoreInstance,
      );

  FirebaseService._internal(
    this._authInstance,
    this._storageInstance,
    this._firestoreInstance,
  );

  void setIsLoggedIn(bool loggedIn) {
    _isLoggedIn = loggedIn;
    notifyListeners();
  }

  Future<String?> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _authInstance.signInWithEmailAndPassword(email: email, password: password);
      setIsLoggedIn(true);
      return null;
    } catch (e) {
      debugPrint('exception in signInWithEmailAndPassword: $e');
      return e.toString();
    }
  }

  Future<(UserCredential?, String?)> createUserWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _authInstance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      setIsLoggedIn(true);

      return (userCredential, null);
    } catch (e) {
      debugPrint('exception in createUserWithEmailAndPassword: $e');
      return (null, e.toString());
    }
  }

  // upload image and return current image reference
  Future<Reference> uploadImageToStorage(String imageName, File? imageFile) async {
    final storageRef = _storageInstance.ref().child(CollectionPath.images.path).child(imageName);

    await storageRef.putFile(imageFile!);

    return storageRef;
  }

  // Retrieve a single user by id
  Future<DocumentSnapshot<Map<String, dynamic>>> getUser({required String collectionPath, required String userid}) async =>
      await _firestoreInstance.collection(collectionPath).doc(userid).get();

  // Delete a message given the currently logged in user
  Future<void> deleteMessage({required String id, required String path}) async {
    final docUsers = _firestoreInstance.collection(path).doc(id);
    await docUsers.delete();
  }

// Send a message by current user
  void sendMessage(abs.User user, String text, String path) async {
    final colRef = FirebaseFirestore.instance.collection(path);
    final textID = colRef.doc().id;
    Message newMessage = UserMessage(userid: user.id, username: user.username, userImageUrl: user.url, textID: textID, text: text);
    await colRef.doc(textID).set(newMessage.toJSON());
  }
}

// ! ---------------------ORIGINAL IMPLEMENTATIONS---------------------------- !

// /// API used to interact with [FirebaseAuth], [FirebaseStorage], and [FirebaseFirestore].
// class FirebaseService extends ChangeNotifier {
//   bool _isLoggedIn = false;

//   late FirebaseAuth _authInstance;
//   late FirebaseStorage _storageInstance;
//   late FirebaseFirestore _firestoreInstance;

//   FirebaseStorage get storageInstance => _storageInstance;

//   User? get currentUser => _authInstance.currentUser;
//   bool get isLoggedIn => _isLoggedIn;

//   FirebaseService() {
//     initialize();
//   }

//   void initialize() {
//     _authInstance = FirebaseAuth.instance;
//     _storageInstance = FirebaseStorage.instance;
//     _firestoreInstance = firestoreService.instance;
//   }

//   void setIsLoggedIn(bool loggedIn) {
//     _isLoggedIn = loggedIn;
//     notifyListeners();
//   }

//   Future<String?> signInWithEmailAndPassword(String email, String password) async {
//     try {
//       await _authInstance.signInWithEmailAndPassword(email: email, password: password);
//       setIsLoggedIn(true);
//       return null;
//     } catch (e) {
//       debugPrint('exception in signInWithEmailAndPassword: $e');
//       return e.toString();
//     }
//   }

//   Future<(UserCredential?, String?)> createUserWithEmailAndPassword(String email, String password) async {
//     try {
//       final userCredential = await _authInstance.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       setIsLoggedIn(true);

//       return (userCredential, null);
//     } catch (e) {
//       debugPrint('exception in createUserWithEmailAndPassword: $e');
//       return (null, e.toString());
//     }
//   }

//   // upload image and return current image reference
//   Future<Reference> uploadImageToStorage(String imageName, File? imageFile) async {
//     final storageRef = _storageInstance.ref().child(CollectionPath.images.path).child(imageName);

//     await storageRef.putFile(imageFile!);

//     return storageRef;
//   }

//   // Retrieve a single user by id
//   Future<DocumentSnapshot<Map<String, dynamic>>> getUser({required String collectionPath, required String userid}) async =>
//       await _firestoreInstance.collection(collectionPath).doc(userid).get();

//   // Delete a message given the currently logged in user
//   Future<void> deleteMessage({required String id, required String path}) async {
//     final docUsers = _firestoreInstance.collection(path).doc(id);
//     await docUsers.delete();
//   }

// // Send a message by current user
//   void sendMessage(abs.User user, String text, String path) async {
//     final colRef = FirebaseFirestore.instance.collection(path);
//     final textID = colRef.doc().id;
//     Message newMessage = UserMessage(userid: user.id, username: user.username, userImageUrl: user.url, textID: textID, text: text);
//     await colRef.doc(textID).set(newMessage.toJSON());
//   }
// }
