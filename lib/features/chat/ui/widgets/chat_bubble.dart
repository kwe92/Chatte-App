import 'package:chatapp/app/resources/reusables.dart';
import 'package:chatapp/app/theme/colors.dart';
import 'package:chatapp/features/chat/ui/widgets/delete_message_bottom_sheet.dart';
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
                            // bottomSheet(context, message.userid);

                            // Option to delete the message pressed permanently
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => bottomSheet(context: context, messageid: message.textID),
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
                          style: _style(
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

class TextBubble extends StatelessWidget {
  final User currentUser;
  final Message message;

  const TextBubble({
    required this.currentUser,
    required this.message,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const sharedRadius = Radius.circular(18);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: currentUser.id != message.userid
            ? const BorderRadius.only(
                topLeft: sharedRadius,
                bottomRight: sharedRadius,
                topRight: sharedRadius,
              )
            : const BorderRadius.only(
                topLeft: sharedRadius,
                bottomLeft: sharedRadius,
                topRight: sharedRadius,
              ),
        // Chat bubble color based on current user
        color: currentUser.id == message.userid ? AppColor.primaryThemeColor.withOpacity(0.90) : Colors.white,
      ),
      child: Text(
        message.text,
        style: _style(
          context: context,
          currentUser: currentUser,
          message: message,
        ),
      ),
    );
  }
}

TextStyle _style({
  required User currentUser,
  required Message message,
  required context,
  Color? color,
  double fontSize = 14.0,
  FontWeight? weight = FontWeight.bold,
}) =>
    currentUser.id == message.userid
        ? TextStyle(fontSize: fontSize, color: color ?? Colors.white, fontWeight: weight)
        : TextStyle(fontSize: fontSize, color: color ?? Theme.of(context).primaryColor, fontWeight: weight);
