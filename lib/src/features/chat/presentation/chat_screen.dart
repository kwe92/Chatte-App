import 'package:chatapp/src/features/chat/presentation/messages.dart';
import 'package:chatapp/src/features/chat/presentation/send_message_field.dart';
import 'package:chatapp/src/features/create_user/domain/user_model.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    //TODO: also pass this to messages and determine if the message belongs to the currently logged in user
    final authInfo = ModalRoute.of(context)!.settings.arguments as Map;
    final UserModel currentUser = authInfo['currentuser'] as UserModel;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Firebase Demo'),
          ),
          body: Container(
            child: Column(children: <Widget>[
              Expanded(
                  child: Messages(
                user: currentUser,
              )),
              SendMessage(
                userName: currentUser.userName,
                userID: currentUser.id,
              )
            ]),
          )),
    );
  }
}
