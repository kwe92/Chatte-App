// class AuthScreen stfl
// Widget Tree:
//  - Scaffold: background color theme primary color
//    - AuthForm
// nl

import 'package:chatapp/src/constants/source_of_truth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, required this.body});

  final Widget body;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Welcome to Flutter Chat!')),
        backgroundColor: AppColor.backGround2,
        // Theme.of(context).primaryColor,
        body: widget.body,
      ),
    );
  }
}
