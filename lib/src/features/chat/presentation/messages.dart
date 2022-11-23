import 'package:chatapp/src/constants/source_of_truth.dart';
import 'package:chatapp/src/features/chat/domain/message_model.dart';
import 'package:chatapp/src/features/chat/presentation/chat_bubble.dart';
import 'package:chatapp/src/utils/stream_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

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

        // ignore: todo
        //TODO: Implement dynamic list of MessageModel's properly
        // final List<MessageModel> msgModels = [
        //   for (var msg in snapshot.data!) MessageModel.fromJSON(msg)
        // ];

        return ListView.builder(
          reverse: true,
          // padding: EdgeInsets.all(10),
          itemCount: snapshot.data?.length,
          itemBuilder: ((context, index) {
            debugPrint(
              snapshot.data.toString(),
            );
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ChatBubble(
                  userID: msgs[index]['userid'].toString(),
                  text: msgs[index]['text'].toString(),
                ));
          }),
        );
      }),
    );
  }
}
