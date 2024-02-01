import 'package:chatapp/app/resources/reusables.dart';
import 'package:chatapp/features/chat/domain/message_model.dart';
import 'package:chatapp/features/chat/presentation/delete_message_bottom_sheet.dart';
import 'package:chatapp/shared/models/base_user.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final BaseUser currentUser;
  final MessageModel message;

  const ChatBubble({
    required this.currentUser,
    required this.message,
    super.key,
  });

  static const double _radius = 21;

// Styling for user text and user name

  @override
  Widget build(BuildContext context) {
    // Chat Bubble Start
    return Row(
      // Aligns text given current user
      mainAxisAlignment: currentUser.id == message.userid ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        // TODO: Refactor
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              currentUser.id != message.userid
                  ? CircleAvatar(
                      radius: _radius,
                      backgroundImage: NetworkImage(message.userImageUrl),
                    )
                  : const SizedBox(),
              gapW8,
              Expanded(
                // Currently logged in user delete messages on tap
                child: GestureDetector(
                  onLongPress: currentUser.id == message.userid
                      ? () => {
                            // bottomSheet(context, message.userid);

                            // Option to delete the message pressed permanently
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => bottomSheet(context: context, messageid: message.textID),
                            )
                          }
                      : null,
                  //Chat bubble container
                  child: _nameTextBubble(context, currentUser, message),
                ),
              ),
              // Currently Logged in user Avatar
              currentUser.id == message.userid ? gapW8 : const SizedBox(),
              currentUser.id == message.userid
                  ? CircleAvatar(
                      radius: _radius,
                      backgroundImage: NetworkImage(message.userImageUrl),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}

TextStyle _style(
        {double fontSize = 18.0,
        FontWeight? weight = FontWeight.bold,
        required BaseUser currentUser,
        required MessageModel message,
        required context}) =>
    currentUser.id == message.userid
        ? TextStyle(fontSize: fontSize, color: Colors.black, fontWeight: weight)
        : TextStyle(fontSize: fontSize, color: Theme.of(context).primaryColor, fontWeight: weight);

Widget _nameTextBubble(BuildContext context, BaseUser currentUser, MessageModel message) => Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: currentUser.id != message.userid
            ? const BorderRadius.only(
                topRight: Radius.circular(18),
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              )
            : const BorderRadius.only(
                topLeft: Radius.circular(18),
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              )
        // BorderRadius.circular(30)
        ,
        // Chat bubble color based on current user
        color: currentUser.id == message.userid ? Colors.grey[500] : const Color.fromRGBO(228, 231, 233, 1),
      ),
      child:
          // User name and text
          Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // message
          Text(
            message.text,
            style: _style(
              fontSize: 16,
              currentUser: currentUser,
              message: message,
              context: context,
            ),
          ),
          gapH8,
          // username
          Text(
            message.username,
            style: _style(
              fontSize: 16,
              currentUser: currentUser,
              message: message,
              context: context,
            ),
          ),
        ],
      ),
    );
