import 'package:chatapp/src/features/chat/presentation/logout_button.dart';
import 'package:chatapp/src/features/chat/presentation/messages.dart';
import 'package:chatapp/src/features/chat/presentation/send_message_field.dart';
import 'package:chatapp/src/features/create_user/domain/user_model.dart';
import 'package:flutter/material.dart';

// TODO: Show bottom snackbar when a new user enters the chat and if its the first time they are entering the chat then say welcome instead
// TODO: add logout functionality in the AppBar

class ChatScreen extends StatelessWidget {
  const ChatScreen({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    // current user passed from the auth screen
    final authInfo = ModalRoute.of(context)!.settings.arguments as Map;
    final UserModel currentUser = authInfo['currentuser'] as UserModel;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Convertir'),
          actions: logoutButton(context: context),
        ),
        body: Column(children: <Widget>[
          Expanded(
              child: Messages(
            user: currentUser,
          )),
          SendMessage(
            username: currentUser.username,
            userid: currentUser.id,
          )
        ]),
      ),
    );
  }
}
