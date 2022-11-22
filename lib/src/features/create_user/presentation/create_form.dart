// ignore_for_file: prefer_final_fields

import 'package:chatapp/src/constants/source_of_truth.dart';
import 'package:chatapp/src/features/create_user/domain/user_model.dart';
import 'package:chatapp/src/utils/validator.dart';
import 'package:chatapp/src/widgets/form_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateForm extends StatefulWidget {
  const CreateForm({super.key});

  @override
  State<CreateForm> createState() => _CreateFormState();
}

Future<void> _createUser(
    {required TextEditingController userNameController,
    required TextEditingController passwordController,
    required TextEditingController emailController,
    required CollectionReference<Map<String, dynamic>> docRef}) async {
  final userCredentials = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
  final UserModel user = UserModel(
      id: userCredentials.user!.uid,
      userName: userNameController.text,
      password: passwordController.text,
      email: emailController.text);
  final json = user.toJSON();
  await docRef.doc(user.id).set(json);
}

class _CreateFormState extends State<CreateForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _userExists = false;
  String _errMsg = '';
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController userNameController = TextEditingController();

    return Center(
      //TODO: Move the card into its own module
      child: _isLoading
          ? CircularProgressIndicator.adaptive()
          : Card(
              margin: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        _userExists
                            ? Text(
                                _errMsg,
                                style: TextStyle(color: Colors.red),
                              )
                            : const SizedBox(),
                        FormFields(
                          userNameController: userNameController,
                          passwordController: passwordController,
                          emailController: emailController,
                          isLogin: true,
                        ),
                        gaph16,
                        SizedBox(
                          width: 400,
                          child: ElevatedButton(
                            onPressed: () async {
                              final valid = Validator.trySubmit(_formKey);
                              if (valid) {
                                final docRef = FirebaseFirestore.instance
                                    .collection('users');
                                try {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  await _createUser(
                                      userNameController: userNameController,
                                      passwordController: passwordController,
                                      emailController: emailController,
                                      docRef: docRef);
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushReplacementNamed(context, '/');
                                } catch (e) {
                                  setState(() {
                                    _userExists = true;
                                    _errMsg = e.toString();
                                    _isLoading = false;
                                  });
                                  debugPrint(e.toString());
                                }
                              } else {
                                return;
                              }
                            },
                            child: const Text('Submit'),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/');
                            },
                            child: const Text('I already have an account'))
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
