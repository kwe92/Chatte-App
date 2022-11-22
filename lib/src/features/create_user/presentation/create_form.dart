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
    {required UserModel user,
    required DocumentReference<Map<String, dynamic>> docRef}) async {
  final json = user.toJSON();
  await docRef.set(json);
  await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: user.email, password: user.password);
}

class _CreateFormState extends State<CreateForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController userNameController = TextEditingController();

    return Center(
      //TODO: Move the card into its own module
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
                              .collection('users')
                              .doc();
                          final UserModel usr = UserModel(
                              id: docRef.id,
                              userName: userNameController.text,
                              password: passwordController.text,
                              email: emailController.text);
                          await _createUser(user: usr, docRef: docRef);
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacementNamed(context, '/');
                        } else {
                          // ignore: todo
                          //TODO: Inform the user why the button did nothing on press
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
