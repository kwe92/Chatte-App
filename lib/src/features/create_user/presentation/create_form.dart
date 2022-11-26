// ignore_for_file: prefer_final_fields

import 'dart:io';

import 'package:chatapp/src/constants/source_of_truth.dart';
import 'package:chatapp/src/features/create_user/domain/user_model.dart';
import 'package:chatapp/src/features/create_user/presentation/user_image_picker.dart';
import 'package:chatapp/src/utils/validator.dart';
import 'package:chatapp/src/widgets/form_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
    required File? file,
    required CollectionReference<Map<String, dynamic>> colRef}) async {
  final userCredentials = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
  final UserModel user = UserModel(
      id: userCredentials.user!.uid,
      userName: userNameController.text,
      password: passwordController.text,
      email: emailController.text);
  final json = user.toJSON();
  await colRef.doc(user.id).set(json);
  final storageRef = FirebaseStorage.instance
      .ref()
      .child('user_images')
      .child('${user.id}.jpg');
  await storageRef.putFile(file!);
}

class _CreateFormState extends State<CreateForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _userExists = false;
  File? _pickedImage;
  String _errMsg = '';

  void pickedImage(File? pickedimage) => setState(() {
        _pickedImage = pickedimage;
        print('IMEAGE SENT TO FORM: ${pickedimage.toString()}');
      });

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController userNameController = TextEditingController();

    return Center(
      //TODO: Move the card into its own module
      child: _isLoading
          ? const CircularProgressIndicator.adaptive()
          : Card(
              margin: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      UserImagePicker(callback: pickedImage
                          // (image) => setState(() {
                          //   _pickedImage = image;
                          //   print('IMEAGE SENT TO FORM: ${image.toString()}');
                          // }),
                          ),
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            _userExists
                                ? Text(
                                    _errMsg,
                                    style: const TextStyle(color: Colors.red),
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
                              //TODO: This button needs to be its own module
                              child: ElevatedButton(
                                onPressed: () async {
                                  final valid = Validator.trySubmit(_formKey);
                                  if (valid) {
                                    final colRef = FirebaseFirestore.instance
                                        .collection('users');
                                    try {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      await _createUser(
                                          userNameController:
                                              userNameController,
                                          passwordController:
                                              passwordController,
                                          emailController: emailController,
                                          file: _pickedImage,
                                          colRef: colRef);

                                      // ignore: use_build_context_synchronously
                                      Navigator.pushReplacementNamed(
                                          context, '/');
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
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
