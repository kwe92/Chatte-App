// class CreateScreen stfl
// Widget Tree:
//  - Scaffold: background color theme primary color
//    - AuthForm
// nl

import 'package:chatapp/src/widgets/field_scaffold.dart';
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
    return FieldScaffold(
      body: widget.body,
      title: 'Flutter Chat: Sign Up',
      bgColor: Theme.of(context).backgroundColor,
    );
  }
}
