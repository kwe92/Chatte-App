// ignore_for_file: subtype_of_sealed_class

import 'package:chatapp/shared/services/chat_service.dart';
import 'package:chatapp/shared/services/firebase_service.dart';
import 'package:chatapp/shared/services/image_picker_service.dart';
import 'package:chatapp/shared/services/toast_service.dart';
import 'package:chatapp/shared/services/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:mocktail/mocktail.dart';

import 'test_data.dart';

class MockFirebaseService extends Mock implements FirebaseService {}

class MockUserService extends Mock implements UserService {}

class MockDocumentSnapshot<T extends Object> extends Mock implements DocumentSnapshot {}

class MockImagePickerService extends Mock implements ImagePickerService {}

class MockImagePickerPlatform extends Mock implements ImagePickerPlatform {}

class MockToastService extends Mock implements ToastService {}

class MockCollectionReference<T> extends Mock implements CollectionReference {}

class MockChatService extends Mock implements ChatService {}

class MockFirebaseUser extends Mock implements User {
  @override
  String get uid => testUser.id;
}

class MockUserCredential extends Mock implements UserCredential {
  @override
  User? get user => mockFirebaseUser;
}
