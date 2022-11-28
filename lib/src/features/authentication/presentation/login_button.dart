import 'package:chatapp/src/features/create_user/domain/user_model.dart';
import 'package:chatapp/src/utils/user_options.dart';
import 'package:chatapp/src/utils/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

typedef UserNotFoundCallback = void Function(bool userNotFound);
typedef SuccessfulLogin = void Function(bool success);

class LoginButton extends StatelessWidget {
  // Should pass a user model instead?
  const LoginButton(
      {
      // required this.valid,
      required this.formKey,
      required this.userNameController,
      required this.emailController,
      required this.passwordController,
      required this.userNotFoundCallback,
      required this.successCallback,
      super.key});
  // final bool valid;
  final TextEditingController userNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final UserNotFoundCallback userNotFoundCallback;
  final SuccessfulLogin successCallback;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    // SnackBar snackBar = SnackBar(
    //   content: Text(
    //     userNameController.text,
    //     style: const TextStyle(color: Colors.white),
    //   ),
    // );
    return SizedBox(
      width: 400,
      child: ElevatedButton(
        onPressed: () async {
          if (Validator.trySubmit(formKey)) {
            try {
              await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text);

              userNotFoundCallback(false);
              final String userid = FirebaseAuth.instance.currentUser!.uid;
              final docSnapshot = await UserOptions.getUser(
                  collection: 'users', userid: userid);
              final currentUser = UserModel.fromJSON(docSnapshot.data());
              successCallback(true);

              // ScaffoldMessenger.of(context).showSnackBar(snackBar);
              // ignore: use_build_context_synchronously
              Navigator.pushReplacementNamed(context, '/chatscreen',
                  arguments: {'currentuser': currentUser});
            } catch (e) {
              // debugPrint(e.toString());
              userNotFoundCallback(true);
            }
          }
        },
        child: const Text('Login'),
      ),
    );
  }
}
