import 'package:chatapp/src/features/chat/presentation/messages.dart';
import 'package:chatapp/src/features/chat/presentation/send_message_field.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    final String usrID = ModalRoute.of(context)!.settings.arguments.toString();
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Firebase Demo'),
          ),
          body: Container(
            child: Column(children: <Widget>[
              const Expanded(child: Messages()),
              SendMessage(
                userID: usrID,
              )
            ]),
          )),
    );
  }
}
