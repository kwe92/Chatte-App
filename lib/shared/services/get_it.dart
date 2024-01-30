import 'package:chatapp/app/navigation/app_navigator.dart';
import 'package:chatapp/shared/services/chat_service.dart';
import 'package:chatapp/shared/services/firebase_service.dart';
import 'package:chatapp/shared/services/firestore_service.dart';
import 'package:chatapp/shared/services/user_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.I;

void configureDependencies() {
  locator.registerSingleton<FireStoreService>(const FireStoreService());
  locator.registerSingleton<FirebaseService>(FirebaseService());
  locator.registerSingleton<AppNavigator>(AppNavigator());
  locator.registerSingleton<UserService>(UserService());
  locator.registerSingleton<ChatService>(ChatService());
}
