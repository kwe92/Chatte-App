import 'package:chatapp/src/constants/source_of_truth.dart';
import 'package:chatapp/src/features/chat/domain/message_model.dart';
import 'package:chatapp/src/features/chat/presentation/delete_message_bottom_sheet.dart';
import 'package:chatapp/src/features/create_user/domain/user_model.dart';
import 'package:chatapp/src/providers/chats_provider.dart';
import 'package:chatapp/src/utils/user_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(
      {required this.currentUser, required this.message, super.key});
  final UserModel currentUser;
  final MessageModel message;

// Styling for user text and user name
  TextStyle _style(
          {double fontSize = 18.0, FontWeight? weight = FontWeight.bold}) =>
      currentUser.id == message.userid
          ? TextStyle(
              fontSize: fontSize, color: Colors.black, fontWeight: weight)
          : TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: weight);

  @override
  Widget build(BuildContext context) {
    // Chat Bubble Start
    return Row(
      // Aligns text given current user
      mainAxisAlignment: currentUser.id == message.userid
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        // Other user avatar
        currentUser.id != message.userid
            ? CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(message.userImageUrl),
              )
            : const SizedBox(),
        gapw8,
        Expanded(
          // Currently logged in user delete messages on tap
          child: GestureDetector(
            onLongPress: currentUser.id == message.userid
                ? () {
                    // bottomSheet(context, message.userid);

                    // Option to delete the message pressed permanently
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => bottomSheet(
                          context: context, messageid: message.textID),
                    );
                  }
                : null,
            //Chat bubble container
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                // Chat bubble color based on current user
                color: currentUser.id == message.userid
                    ? Colors.grey[500]
                    : Theme.of(context).primaryColor,
              ),
              child:
                  // User name and text
                  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // username
                  Text(message.username, style: _style(fontSize: 16)),
                  gaph4,
                  // message
                  Text(
                    message.text,
                    style: _style(weight: null),
                  )
                ],
              ),
            ),
          ),
        ),
        // Currently Logged in user Avatar
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
