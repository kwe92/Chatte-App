// class AuthForm stfl
// widget tree
//  - Center
//    - Card with margin
//      - SingChildScrollView
//        - Padding
//          - Form
//            - Column maxAlign.min (to take up as little space as needed) collect email, username and [password]
//                - <Widget>[TextFormField(keyboardType, decoration, labelText, labelStyle)] password TextField should have obscure true
//                - Button to login
//                - Button to create account | Try FlatButton first
// nl

import 'package:chatapp/src/constants/source_of_truth.dart';
import 'package:chatapp/src/features/create_user/domain/user_model.dart';
import 'package:chatapp/src/utils/validator.dart';
import 'package:chatapp/src/widgets/form_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//TODO: Add image Picker functionality

class AuthForm extends StatefulWidget {
  const AuthForm({super.key, required this.onPressed});
  final void Function() onPressed;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

Future<DocumentSnapshot<Map<String, dynamic>>> _getUser(
        {required collection, required userid}) async =>
    await FirebaseFirestore.instance.collection(collection).doc(userid).get();

class _AuthFormState extends State<AuthForm> {
  // ignore: todo
  //TODO: Research Global Keys
  // GlobalKey in this case is used to access the current state and call FormState.validate()
  final _formKey = GlobalKey<FormState>();
  bool _userNotFound = false;
  //   //TODO: Need to read up on FocusScope and this whole line of code
  // FocusScope.of(context).unfocus();

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController userNameController = TextEditingController();
    return Center(
      child: Card(
        margin: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _userNotFound
                      ? const Text(
                          'Wrong username or password',
                          style: TextStyle(color: Colors.red),
                        )
                      : const SizedBox(),
                  FormFields(
                      userNameController: userNameController,
                      passwordController: passwordController,
                      emailController: emailController),
                  gaph16,
                  SizedBox(
                    width: 400,

                    // Log in Button
                    //TODO: The log in button needs to be its own module | Narrow Interface | Law of Demeter | Dry Code | Modular Code
                    child: ElevatedButton(
                      onPressed: () async {
                        final bool valid = Validator.trySubmit(_formKey);
                        if (valid) {
                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text);
                            // Reset email and password
                            setState(() {
                              _userNotFound = false;
                            });
                            final String userid =
                                FirebaseAuth.instance.currentUser!.uid;
                            final docSnapshot = await _getUser(
                                collection: 'users', userid: userid);
                            final currentUser =
                                UserModel.fromJSON(docSnapshot.data());
                            // print("USER NAME: ${currentUser.userName}");

                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacementNamed(
                                context, '/chatscreen',
                                arguments: {'currentuser': currentUser});
                          } catch (e) {
                            debugPrint(e.toString());
                            setState(() {
                              _userNotFound = true;
                            });
                          }
                        }
                        // debugPrint(userNameController.text);
                        // debugPrint(emailController.text);
                        // debugPrint(passwordController.text);
                      },
                      child: const Text('Login'),
                    ),
                  ),
                  // gaph8,
                  TextButton(
                      onPressed: () {
                        widget.onPressed();
                      },
                      child: const Text('Create Account'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
