import 'dart:io';

import 'package:chatapp/src/constants/source_of_truth.dart';
import 'package:chatapp/src/features/chat/domain/message_model.dart';
import 'package:chatapp/src/features/create_user/domain/user_model.dart';
import 'package:flutter/material.dart';

//TODO: Save image URL to the text?? need to be able to see other users images

//TODO: TextTile bubble? with a container?
//TODO: Change the color and positioning of the buble depending on who is logged in
//TODO: Show the current user and maybe a filler circular avatar for the user picture

class ChatBubble extends StatelessWidget {
  const ChatBubble(
      {required this.currentUser, required this.message, super.key});
  final UserModel currentUser;
  final MessageModel message;

  TextStyle _style(
          {double fontSize = 18.0, FontWeight? weight = FontWeight.bold}) =>
      currentUser.id == message.userid
          ? TextStyle(
              fontSize: fontSize, color: Colors.black, fontWeight: weight)
          : TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: weight);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: currentUser.id == message.userid
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        currentUser.id != message.userid
            ? CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(message.userImageUrl),
              )
            : const SizedBox(),
        gapw8,
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: currentUser.id == message.userid
                  ? Colors.grey[500]
                  : Theme.of(context).primaryColor,
            ),
            child: Column(
              children: [
                Text(message.username, style: _style(fontSize: 16)),
                gaph4,
                Text(
                  message.text,
                  style: _style(weight: null),
                )
              ],
            ),
          ),
        ),
        currentUser.id == message.userid ? gapw8 : const SizedBox(),
        currentUser.id == message.userid
            ? CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(message.userImageUrl),
              )
            : const SizedBox(),
      ],
    );
  }
}
