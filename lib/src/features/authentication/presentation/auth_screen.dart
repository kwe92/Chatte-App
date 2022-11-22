// class AuthScreen stfl
// Widget Tree:
//  - Scaffold: background color theme primary color
//    - AuthForm
// nl
//TODO: Change animation upon navigation to a diffrent screen, right now it fades in kinda ugly
import 'package:chatapp/src/widgets/field_scaffold.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, required this.body, required this.title});

  final Widget body;
  final String title;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return FieldScaffold(
      body: widget.body,
      title: widget.title,
      bgColor: Theme.of(context).backgroundColor,
    );
  }
}
