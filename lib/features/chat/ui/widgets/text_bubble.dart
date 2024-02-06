import 'package:chatapp/app/theme/colors.dart';
import 'package:chatapp/app/theme/text_styles.dart';
import 'package:chatapp/shared/models/message.dart';
import 'package:chatapp/shared/models/user.dart';
import 'package:flutter/material.dart';

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
      child: Column(
        children: [
          message.messageImageUrl != null && message.messageImageUrl!.isNotEmpty
              ? Image.network(message.messageImageUrl!)
              : const SizedBox(),
          Text(
            message.text,
            style: chatTextStyle(
              context: context,
              currentUser: currentUser,
              message: message,
            ),
          ),
        ],
      ),
    );
  }
}
