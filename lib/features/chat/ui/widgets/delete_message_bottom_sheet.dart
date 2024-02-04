// ignore_for_file: use_build_context_synchronously

import 'package:chatapp/app/providers/chats_provider.dart';
import 'package:chatapp/shared/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget bottomSheet({required BuildContext context, required String messageid}) => SizedBox(
      height: 100,
      child: Center(
        child: Consumer(
          builder: ((context, ref, child) => TextButton(
                onPressed: () async {
                  final String path = ref.read(chatProvider.notifier).state;

                  await chatService.deleteMessage(id: messageid, path: path);

                  Navigator.pop(context);
                },
                child: const Text('Delete Message'),
              )),
        ),
      ),
    );
