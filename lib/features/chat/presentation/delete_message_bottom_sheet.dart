import 'package:chatapp/app/providers/chats_provider.dart';
import 'package:chatapp/app/utils/user_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget bottomSheet({required BuildContext context, required String messageid}) => SizedBox(
      height: 100,
      child: Center(
        child: Consumer(
          builder: ((context, ref, child) => TextButton(
              onPressed: () async {
                final String path = ref.read(chatProvider.notifier).state;
                await UserOptions.deleteMessage(id: messageid, path: path);
                Navigator.pop(context);
              },
              child: const Text('Delete Message'))),
        ),
      ),
    );
