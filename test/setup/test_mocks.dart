// ignore_for_file: subtype_of_sealed_class

import 'package:chatapp/shared/services/firebase_service.dart';
import 'package:chatapp/shared/services/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mocktail/mocktail.dart';

import 'test_data.dart';

class MockFirebaseService extends Mock implements FirebaseService {}

class MockUserService extends Mock implements UserService {}

class MockDocumentSnapshot<T extends Object> extends Mock implements DocumentSnapshot {}

class MockFirebaseUser extends Mock implements User {
  @override
  String get uid => testUser.id;
}
