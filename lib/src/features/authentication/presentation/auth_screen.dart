//TODO: Change animation upon navigation to a diffrent screen, right now it fades in kinda ugly
import 'package:chatapp/src/features/authentication/presentation/auth_form.dart';
import 'package:chatapp/src/widgets/field_scaffold.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({required this.title, super.key});

  final String title;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return FieldScaffold(
      body: const AuthForm(),
      title: widget.title,
      bgColor: Theme.of(context).backgroundColor,
    );
  }
}
