// class CreateScreen stfl
// Widget Tree:
//  - Scaffold: background color theme primary color
//    - AuthForm
// nl

import 'package:chatapp/src/constants/source_of_truth.dart';
import 'package:flutter/material.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key, required this.body});

  final Widget body;

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Sign Up!')),
        backgroundColor: AppColor.backGround2,
        // Theme.of(context).primaryColor,
        body: widget.body,
      ),
    );
  }
}
