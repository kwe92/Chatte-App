import 'package:chatapp/features/create_user/domain/user_model.dart';
import 'package:chatapp/app/utils/user_options.dart';
import 'package:chatapp/app/utils/validator.dart';
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
    return SizedBox(
      width: 400,
      child: ElevatedButton(
        onPressed: () async {
          if (Validator.trySubmit(formKey)) {
            try {
              await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);

              // Callback to show user an error message if the user is not found
              userNotFoundCallback(false);

              final String userid = FirebaseAuth.instance.currentUser!.uid;

              // Get user by id
              final docSnapshot = await UserOptions.getUser(collection: 'users', userid: userid);

              // Currently logged in user data
              final currentUser = UserModel.fromJSON(docSnapshot.data());
              successCallback(true);

              //Navigate to the chat page and push the current users data as well
              // ignore: use_build_context_synchronously
              Navigator.pushReplacementNamed(context, '/chatscreen', arguments: {'currentuser': currentUser});
            }
            // Catch any error thrown and display a user not found messasge to the user
            catch (e) {
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
