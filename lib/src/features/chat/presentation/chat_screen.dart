import 'package:chatapp/src/features/chat/presentation/logout_button.dart';
import 'package:chatapp/src/features/chat/presentation/messages.dart';
import 'package:chatapp/src/features/chat/presentation/send_message_field.dart';
import 'package:chatapp/src/features/create_user/domain/user_model.dart';
import 'package:flutter/material.dart';

// TODO: Show bottom snackbar when a new user enters the chat and if its the first time they are entering the chat then say welcome instead

class ChatScreen extends StatelessWidget {
  const ChatScreen({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    // Dummy user
    // const UserModel currentUser = UserModel(
    //     id: '9999',
    //     email: 'goku@dbz.com',
    //     password: 'Bbz123!!@@',
    //     username: 'Gohan',
    //     url: '');

    // current user passed from the auth screen
    final authInfo = ModalRoute.of(context)!.settings.arguments as Map;
    final UserModel currentUser = authInfo['currentuser'] as UserModel;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Convertir'),
          // option for user to logout
          actions: logoutButton(context: context),
        ),
        body: Column(children: <Widget>[
          Expanded(
              // Scrollable list of messages from authorized users
              child: Messages(
            user: currentUser,
          )),
          // Send message widget
          SendMessage(
            user: currentUser,
          ),
        ]),
      ),
    );
  }
}
