import 'package:chatapp/app/resources/reusables.dart';
import 'package:chatapp/app/theme/text_styles.dart';
import 'package:chatapp/features/chat/ui/widgets/delete_message_bottom_sheet.dart';
import 'package:chatapp/features/chat/ui/widgets/text_bubble.dart';
import 'package:chatapp/shared/models/message.dart';
import 'package:chatapp/shared/models/user.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final User currentUser;
  final Message message;

  const ChatBubble({
    required this.currentUser,
    required this.message,
    super.key,
  });

  static const double _radius = 21;

  @override
  Widget build(BuildContext context) {
    // Chat Bubble Start
    return Row(
      // Aligns text given current user
      mainAxisAlignment: currentUser.id == message.userid ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
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
                            // Option to delete the message pressed permanently
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => DeleteMessage(messageid: message.textID),
                            )
                          }
                      : null,
                  //Chat bubble container
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: currentUser.id == message.userid ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        TextBubble(currentUser: currentUser, message: message),
                        gapH4,
                        Text(
                          message.username,
                          style: chatTextStyle(
                            context: context,
                            color: const Color(0xff4f4f4f),
                            currentUser: currentUser,
                            message: message,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Currently Logged in user Avatar
              gapW8,
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
