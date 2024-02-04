import 'package:chatapp/features/chat/ui/widgets/chat_bubble.dart';
import 'package:chatapp/shared/models/message.dart';
import 'package:chatapp/shared/models/user_message.dart';
import 'package:chatapp/shared/models/user.dart';
import 'package:chatapp/app/providers/chats_provider.dart';
import 'package:chatapp/shared/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Messages extends ConsumerWidget {
  final User user;

  const Messages({required this.user, super.key});

  @override
  Widget build(BuildContext context, ref) {
    return StreamBuilder(
      // Generate a list of all messages in the Firestore instance
      stream: firestoreService.getAllDocuments(
        collectionPath: ref.read(chatProvider.notifier).state,
        orderBy: 'timestamp',
      ),
      builder: ((context, snapshot) {
        // Loading page
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator.adaptive();
        }
        // Error page
        if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString(),
            ),
          );
        }

        // Dynamic list of message models
        final List<Message> msgModels = [for (var msg in snapshot.data!) UserMessage.fromJSON(msg)];

        return ListView.builder(
          reverse: true,
          // padding: EdgeInsets.all(10),
          itemCount: msgModels.length,
          itemBuilder: ((context, index) {
            return Padding(
                padding: const EdgeInsets.all(8.0),
                // Pass the current user create a chate bubble for each message
                child: ChatBubble(
                  currentUser: user,
                  message: msgModels[index],
                  key: ValueKey(msgModels[index].textID),
                ));
          }),
        );
      }),
    );
  }
}