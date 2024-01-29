import 'dart:io';

import 'package:chatapp/features/chat/domain/message_model.dart';
import 'package:chatapp/shared/models/base_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

// TODO: write comments
class FirebaseService {
  late FirebaseAuth authInstance;
  late FirebaseStorage storageInstance;
  late FirebaseFirestore firestoreInstance;

  FirebaseService() {
    initialize();
  }

  void initialize() {
    authInstance = FirebaseAuth.instance;
    storageInstance = FirebaseStorage.instance;
    firestoreInstance = FirebaseFirestore.instance;
  }

  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    await authInstance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // uplead image and return current image reference
  Future<Reference> uploadImageToStorage(String imageName, File imageFile) async {
    final storageRef = storageInstance.ref().child('user_images').child('$imageName.jpg');
    await storageRef.putFile(imageFile);

    return storageRef;
  }

  // Retrieve a single user by id
  Future<DocumentSnapshot<Map<String, dynamic>>> getUser({required String collectionPath, required userid}) async =>
      await firestoreInstance.collection(collectionPath).doc(userid).get();

  // Delete a message given the currently logged in user
  Future<void> deleteMessage({required String id, required String path}) async {
    final docUsers = firestoreInstance.collection(path).doc(id);
    await docUsers.delete();
  }

// Send a message by current user
  void sendMessage(BaseUser user, String text, String path) {
    final colRef = FirebaseFirestore.instance.collection(path);
    final textID = colRef.doc().id;
    MessageModel newMessage = MessageModel(userid: user.id, username: user.username, userImageUrl: user.url, textID: textID, text: text);
    colRef.doc(textID).set(newMessage.toJSON());
  }
}
