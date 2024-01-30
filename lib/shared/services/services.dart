import 'package:chatapp/app/navigation/app_navigator.dart';
import 'package:chatapp/shared/services/chat_service.dart';
import 'package:chatapp/shared/services/firebase_service.dart';
import 'package:chatapp/shared/services/firestore_service.dart';
import 'package:chatapp/shared/services/get_it.dart';
import 'package:chatapp/shared/services/user_service.dart';

FireStoreService get firestoreService => locator.get<FireStoreService>();
FirebaseService get firebaseService => locator.get<FirebaseService>();
AppNavigator get appNavigator => locator.get<AppNavigator>();
UserService get userService => locator.get<UserService>();

ChatService get chatService => locator.get<ChatService>();
