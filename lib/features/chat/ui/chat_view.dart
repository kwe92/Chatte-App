import 'package:chatapp/app/theme/colors.dart';
import 'package:chatapp/features/chat/ui/chat_view_model.dart';
import 'package:chatapp/features/chat/ui/widgets/messages.dart';
import 'package:chatapp/features/chat/ui/widgets/send_message_field.dart';
import 'package:chatapp/shared/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// TODO: Show bottom snackbar when a new user enters the chat and if its the first time they are entering the chat then say welcome instead

// TODO: add busy state when image pick starts

class ChatView extends StatelessWidget {
  final User currentUser;

  const ChatView({required this.currentUser, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.chatBgColor,
      appBar: AppBar(
        foregroundColor: AppColor.primaryThemeColor,
        scrolledUnderElevation: 0,
        title: const Text('Chatte'),
      ),
      body: ChangeNotifierProvider(
          create: (context) => ChatViewModel(),
          builder: (context, _) {
            // final model = Provider.of<ChatViewModel>(context);
            return Stack(
              children: [
                // if (model.isBusy) paddedIndicator,
                Column(
                  children: <Widget>[
                    Expanded(
                      // Scrollable list of messages from authorized users
                      child: Messages(
                        user: currentUser,
                      ),
                    ),
                    // Send message widget
                    SendMessage(
                      user: currentUser,
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }
}
