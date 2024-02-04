import 'package:chatapp/features/chat/presentation/logout_button.dart';
import 'package:chatapp/features/chat/presentation/messages.dart';
import 'package:chatapp/features/chat/presentation/send_message_field.dart';
import 'package:chatapp/shared/models/user.dart';
import 'package:flutter/material.dart';

// TODO: Show bottom snackbar when a new user enters the chat and if its the first time they are entering the chat then say welcome instead

class ChatScreen extends StatelessWidget {
  final User currentUser;

  const ChatScreen({required this.currentUser, super.key});

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
    // final authInfo = ModalRoute.of(context)!.settings.arguments as Map;
    // final User currentUser = authInfo['currentuser'] as User;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chatte'),
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
