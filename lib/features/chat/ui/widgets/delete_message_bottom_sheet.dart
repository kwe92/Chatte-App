// ignore_for_file: use_build_context_synchronously

import 'package:chatapp/app/general/constants.dart';
import 'package:chatapp/shared/services/services.dart';
import 'package:flutter/material.dart';

class DeleteMessage extends StatelessWidget {
  final String messageid;
  const DeleteMessage({required this.messageid, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Center(
          child: TextButton(
        onPressed: () async {
          await chatService.deleteMessage(messageid, CollectionPath.chat.path);

          Navigator.pop(context);
        },
        child: const Text('Delete Message'),
      )),
    );
  }
}
