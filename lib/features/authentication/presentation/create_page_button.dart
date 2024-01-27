import 'package:flutter/material.dart';

class ToCreatePageButton extends StatelessWidget {
  const ToCreatePageButton({super.key});

  @override
  Widget build(BuildContext context) => TextButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, '/createuser');
      },
      child: const Text('Create Account'));
}
