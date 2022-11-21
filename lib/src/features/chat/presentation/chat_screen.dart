import 'package:chatapp/src/constants/source_of_truth.dart';
import 'package:chatapp/src/utils/stream_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({required this.title, super.key});
  final String title;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Firebase Demo'),
        ),
        body: StreamBuilder(
          stream: StreamFireStore.getListDocsData(
              collectionPath: 'chats/amAflxUTjTvrI261RJYi/messages'),
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
            return ListView.builder(
              // padding: EdgeInsets.all(10),
              itemCount: snapshot.data?.length,
              itemBuilder: ((context, index) {
                debugPrint(snapshot.data.toString());
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 110,
                    decoration: BoxDecoration(color: AppColor.main),
                    child: Center(
                      child: Text(
                        msgs[index]['text'].toString(),
                        style: const TextStyle(
                            fontSize: 18.0, color: Colors.white),
                      ),
                    ),
                  ),
                );
              }),
            );
          }),
        ),
      ),
    );
  }
}
