import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  late FirebaseAuth instance;

  FirebaseAuthService() {
    instance = FirebaseAuth.instance;
  }
}
