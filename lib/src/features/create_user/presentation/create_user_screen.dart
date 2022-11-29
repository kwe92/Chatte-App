import 'package:chatapp/src/features/create_user/presentation/create_form.dart';
import 'package:chatapp/src/widgets/field_scaffold.dart';
import 'package:flutter/material.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  @override
  Widget build(BuildContext context) {
    return FieldScaffold(
      body: const CreateForm(),
      title: 'Convertir: Sign Up',
      bgColor: Theme.of(context).backgroundColor,
    );
  }
}
