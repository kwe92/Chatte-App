import 'package:chatapp/src/features/create_user/domain/user_model.dart';
import 'package:chatapp/src/utils/validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

typedef UserNotFoundCallback = void Function(bool userNotFound);

class LoginButton extends StatelessWidget {
  const LoginButton(
      {
      // required this.valid,
      required this.formKey,
      required this.emailController,
      required this.passwordController,
      required this.callback,
      super.key});
  // final bool valid;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final UserNotFoundCallback callback;
  final GlobalKey<FormState> formKey;

  Future<DocumentSnapshot<Map<String, dynamic>>> _getUser(
          {required collection, required userid}) async =>
      await FirebaseFirestore.instance.collection(collection).doc(userid).get();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (Validator.trySubmit(formKey)) {
          try {
            await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
            callback(false);
            // Reset email and password
            // setState(() {
            //   _userNotFound = false;
            // });
            final String userid = FirebaseAuth.instance.currentUser!.uid;
            final docSnapshot =
                await _getUser(collection: 'users', userid: userid);
            final currentUser = UserModel.fromJSON(docSnapshot.data());
            // print("USER NAME: ${currentUser.userName}");

            // ignore: use_build_context_synchronously
            Navigator.pushReplacementNamed(context, '/chatscreen',
                arguments: {'currentuser': currentUser});
          } catch (e) {
            debugPrint(e.toString());
            callback(true);
            // setState(() {
            //   _userNotFound = true;
            // });
          }
        }
        // debugPrint(userNameController.text);
        // debugPrint(emailController.text);
        // debugPrint(passwordController.text);
      },
      child: const Text('Login'),
    );
  }
}
