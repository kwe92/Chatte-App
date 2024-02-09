// ignore_for_file: subtype_of_sealed_class

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:chatapp/shared/models/user.dart' as abs;
import 'package:chatapp/shared/models/user_message.dart';
import 'package:chatapp/shared/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'test_mocks.dart';

const abs.User testUser = UserModel(
  id: '1101',
  email: 'baki@grappler.io',
  password: 'Password11!!',
  username: 'baki',
  url: 'profile-image.bucket.firebase',
);

const testMessage = UserMessage(
  userid: "1101",
  username: "baki",
  userImageUrl: "profile-image.bucket.firebase",
  textID: "1101",
  text: "be in the present moment, forgetting yourself.",
);

const testMessageWithImage = UserMessage(
  userid: "1101",
  username: "baki",
  userImageUrl: "profile-image.bucket.firebase",
  textID: "1101",
  text: "be in the present moment, forgetting yourself.",
  messageImageUrl: "message-image.bucket.firebase",
  messageImageFileName: "i-am-the-image.jpg",
);

final testPickedImage = File("/Users/kwe/flutter-projects/ChatApp/chatapp/assets/apple_icon.png");

final mockDocumentSnapshot = MockDocumentSnapshot<Map<String, dynamic>>();

final mockFirebaseUser = MockFirebaseUser();

final mockUserCredential = MockUserCredential();

final mockCollectionReference = MockCollectionReference<Map<String, dynamic>>() as CollectionReference<Map<String, dynamic>>;

final testReference = TestReference();

// final testFirebaseStorageRef = FirebaseStorage.instance.ref();

class TestReference implements Reference {
  @override
  // TODO: implement bucket
  String get bucket => throw UnimplementedError();

  @override
  Reference child(String path) {
    // TODO: implement child
    throw UnimplementedError();
  }

  @override
  Future<void> delete() async {
    print("image delete!");
  }

  @override
  // TODO: implement fullPath
  String get fullPath => throw UnimplementedError();

  @override
  Future<Uint8List?> getData([int maxSize = 10485760]) {
    // TODO: implement getData
    throw UnimplementedError();
  }

  @override
  Future<String> getDownloadURL() async {
    // TODO: implement getDownloadURL
    return "https://some-url.io";
  }

  @override
  Future<FullMetadata> getMetadata() {
    // TODO: implement getMetadata
    throw UnimplementedError();
  }

  @override
  Future<ListResult> list([ListOptions? options]) {
    // TODO: implement list
    throw UnimplementedError();
  }

  @override
  Future<ListResult> listAll() {
    // TODO: implement listAll
    throw UnimplementedError();
  }

  @override
  // TODO: implement name
  String get name => throw UnimplementedError();

  @override
  // TODO: implement parent
  Reference? get parent => throw UnimplementedError();

  @override
  UploadTask putBlob(blob, [SettableMetadata? metadata]) {
    // TODO: implement putBlob
    throw UnimplementedError();
  }

  @override
  UploadTask putData(Uint8List data, [SettableMetadata? metadata]) {
    // TODO: implement putData
    throw UnimplementedError();
  }

  @override
  UploadTask putFile(File file, [SettableMetadata? metadata]) {
    // TODO: implement putFile
    throw UnimplementedError();
  }

  @override
  UploadTask putString(String data, {PutStringFormat format = PutStringFormat.raw, SettableMetadata? metadata}) {
    // TODO: implement putString
    throw UnimplementedError();
  }

  @override
  // TODO: implement root
  Reference get root => throw UnimplementedError();

  @override
  // TODO: implement storage
  FirebaseStorage get storage => throw UnimplementedError();

  @override
  Future<FullMetadata> updateMetadata(SettableMetadata metadata) {
    // TODO: implement updateMetadata
    throw UnimplementedError();
  }

  @override
  DownloadTask writeToFile(File file) {
    // TODO: implement writeToFile
    throw UnimplementedError();
  }
}

// TODO: figure out why this is not working with getUser stub

final DocumentSnapshot<Map<String, dynamic>> testDocumentSnapshot =
    TestDocumentSnapshot<Map<String, dynamic>>() as DocumentSnapshot<Map<String, dynamic>>;

class TestDocumentSnapshot<T> extends DocumentSnapshot {
  @override
  operator [](Object field) {
    // TODO: implement []
    throw UnimplementedError();
  }

  @override
  Object? data() {
    return {
      'id': testUser.id,
      'password': testUser.password,
      'email': testUser.email,
      'username': testUser.username,
      'imageurl': testUser.url,
    };
  }

  @override
  // TODO: implement exists
  bool get exists => throw UnimplementedError();

  @override
  get(Object field) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  // TODO: implement id
  String get id => throw UnimplementedError();

  @override
  // TODO: implement metadata
  SnapshotMetadata get metadata => throw UnimplementedError();

  @override
  // TODO: implement reference
  DocumentReference<Object?> get reference => throw UnimplementedError();
}
