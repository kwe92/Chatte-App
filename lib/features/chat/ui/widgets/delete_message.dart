// ignore_for_file: use_build_context_synchronously

import 'package:chatapp/features/chat/ui/chat_view_model.dart';
import 'package:chatapp/shared/models/message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeleteMessage extends StatelessWidget {
  final Message message;
  const DeleteMessage({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ChangeNotifierProvider(
        create: (context) => ChatViewModel(),
        builder: (context, _) {
          return Center(
            child: TextButton(
              onPressed: () async {
                await context.read<ChatViewModel>().deleteMessage(message);

                Navigator.pop(context);
              },
              child: const Text('Delete Message'),
            ),
          );
        },
      ),
    );
  }
}
