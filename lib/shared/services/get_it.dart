import 'package:chatapp/shared/services/firebase_auth_service.dart';
import 'package:chatapp/shared/services/firestore_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.I;

void configureDependencies() {
  locator.registerSingleton<FireStoreService>(const FireStoreService());
  locator.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
}
