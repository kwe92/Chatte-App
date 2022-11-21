// class CreateScreen stfl
// Widget Tree:
//  - Scaffold: background color theme primary color
//    - AuthForm
// nl

import 'package:chatapp/src/constants/source_of_truth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key, required this.body});

  final Widget body;

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

Future<void> _createUser(
    {required name, required age, required birthdate}) async {
  final docUsers = FirebaseFirestore.instance.collection('users').doc();
  // final newUser =
  //     UserModel(id: docUsers.id, name: name, age: age, birthdate: birthdate);
  // final json = newUser.toJSON();
  // await docUsers.set(json);
}

class _CreateScreenState extends State<CreateScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Flutter Chat: Sign Up')),
        backgroundColor: Theme.of(context).backgroundColor,
        body: widget.body,
      ),
    );
  }
}
