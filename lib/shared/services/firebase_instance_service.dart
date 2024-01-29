import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

// TODO: refactor to just firebase service and call methods here
class FirebaseInstanceService {
  late FirebaseAuth authInstance;
  late FirebaseStorage storageInstance;

  FirebaseInstanceService() {
    authInstance = FirebaseAuth.instance;
    storageInstance = FirebaseStorage.instance;
  }
}
