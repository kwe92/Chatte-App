import 'package:chatapp/app/navigation/app_navigator.dart';
import 'package:chatapp/shared/controllers/password_visiblity_controller.dart';
import 'package:chatapp/shared/services/chat_service.dart';
import 'package:chatapp/shared/services/firebase_service.dart';
import 'package:chatapp/shared/services/firestore_service.dart';
import 'package:chatapp/shared/services/image_picker_service.dart';
import 'package:chatapp/shared/services/key_service.dart';
import 'package:chatapp/shared/services/services.dart';
import 'package:chatapp/shared/services/string_service.dart';
import 'package:chatapp/shared/services/toast_service.dart';
import 'package:chatapp/shared/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.I;

void configureDependencies() {
  locator.registerSingleton<FireStoreService>(const FireStoreService());
  locator.registerSingleton<FirebaseService>(FirebaseService(
    authInstance: FirebaseAuth.instance,
    storageInstance: FirebaseStorage.instance,
    firestoreInstance: firestoreService.instance,
  ));
  locator.registerSingleton<AppNavigator>(AppNavigator());
  locator.registerSingleton<UserService>(UserService());
  locator.registerSingleton<ChatService>(ChatService());
  locator.registerSingleton<StringService>(StringService());
  locator.registerSingleton<ToastService>(ToastService());
  locator.registerSingleton<ImagePickerService>(ImagePickerService());
  locator.registerSingleton<KeyService>(KeyService());
  locator.registerSingleton<PasswordVisibilityController>(PasswordVisibilityController());
  locator.registerFactory<FlutterSecureStorage>(() => const FlutterSecureStorage());
}
