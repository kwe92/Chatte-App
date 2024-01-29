import 'package:chatapp/features/create_user/presentation/create_form.dart';
import 'package:chatapp/shared/widgets/base_scaffold.dart';
import 'package:flutter/material.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: const CreateForm(),
      title: 'Convertir: Sign Up',
      bgColor: Theme.of(context).backgroundColor,
    );
  }
}
