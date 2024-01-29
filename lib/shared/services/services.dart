import 'package:chatapp/shared/services/firebase_auth_service.dart';
import 'package:chatapp/shared/services/firestore_service.dart';
import 'package:chatapp/shared/services/get_it.dart';

FireStoreService get firestoreService => locator.get<FireStoreService>();
FirebaseAuthService get firebaseAuthService => locator.get<FirebaseAuthService>();
