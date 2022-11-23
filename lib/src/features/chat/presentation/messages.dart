import 'package:chatapp/src/constants/source_of_truth.dart';
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
              child: Container(
                height: 110,
                decoration: BoxDecoration(color: AppColor.main),
                child: Center(
                  //TODO: Turn this into a text tile with text top, user name bottom and picture as an icon
                  child: Column(
                    children: [
                      Text(
                        msgs[index]['text'].toString(),
                        style: const TextStyle(
                            fontSize: 18.0, color: Colors.white),
                      ),
                      Text(msgs[index]['userid'].toString())
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      }),
    );
  }
}
