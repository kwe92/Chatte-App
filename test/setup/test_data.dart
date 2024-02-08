import 'dart:io';

import 'package:chatapp/shared/models/user.dart' as abs;
import 'package:chatapp/shared/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'test_mocks.dart';

const abs.User testUser = UserModel(
  id: '1101',
  email: 'baki@grappler.io',
  password: 'Password11!!',
  username: 'baki',
  url: 'profile-image.bucket.firebase',
);

final testPickedImage = File("/Users/kwe/flutter-projects/ChatApp/chatapp/assets/apple_icon.png");

final mockDocumentSnapshot = MockDocumentSnapshot<Map<String, dynamic>>();

final mockFirebaseUser = MockFirebaseUser();

final mockUserCredential = MockUserCredential();

final mockCollectionReference = MockCollectionReference<Map<String, dynamic>>() as CollectionReference<Map<String, dynamic>>;
