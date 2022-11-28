import 'package:chatapp/src/features/chat/domain/message_model.dart';
import 'package:chatapp/src/features/chat/presentation/chat_bubble.dart';
import 'package:chatapp/src/features/create_user/domain/user_model.dart';
import 'package:chatapp/src/utils/stream_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({required this.user, super.key});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: StreamFireStore.getListDocsData(
          collectionPath: '/chat/3Rzps9JekqBlFfihf2Jq/messages',
          orderBy: 'timestamp'),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator.adaptive();
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString(),
            ),
          );
        }
        final List<Map<String, dynamic>> msgs = snapshot.data!;

        final List<MessageModel> msgModels = [
          for (var msg in snapshot.data!) MessageModel.fromJSON(msg)
        ];

        return ListView.builder(
          reverse: true,
          // padding: EdgeInsets.all(10),
          itemCount: snapshot.data?.length,
          itemBuilder: ((context, index) {
            return Padding(
                padding: const EdgeInsets.all(8.0),
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
