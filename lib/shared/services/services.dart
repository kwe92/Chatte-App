import 'package:chatapp/app/navigation/app_navigator.dart';
import 'package:chatapp/shared/controllers/password_visiblity_controller.dart';
import 'package:chatapp/shared/services/chat_service.dart';
import 'package:chatapp/shared/services/firebase_service.dart';
import 'package:chatapp/shared/services/firestore_service.dart';
import 'package:chatapp/shared/services/get_it.dart';
import 'package:chatapp/shared/services/image_picker_service.dart';
import 'package:chatapp/shared/services/key_service.dart';
import 'package:chatapp/shared/services/string_service.dart';
import 'package:chatapp/shared/services/toast_service.dart';
import 'package:chatapp/shared/services/user_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// TODO: create an abstract base class for Services | start with app router

FireStoreService get firestoreService => locator.get<FireStoreService>();
FirebaseService get firebaseService => locator.get<FirebaseService>();
AppNavigator get appNavigator => locator.get<AppNavigator>();
UserService get userService => locator.get<UserService>();
ChatService get chatService => locator.get<ChatService>();
StringService get stringService => locator.get<StringService>();
ToastService get toastService => locator.get<ToastService>();
ImagePickerService get imagePickerService => locator.get<ImagePickerService>();
KeyService get keyService => locator.get<KeyService>();

PasswordVisibilityController get passwordVisibilityController => locator.get<PasswordVisibilityController>();
FlutterSecureStorage get storage => locator.get<FlutterSecureStorage>();
