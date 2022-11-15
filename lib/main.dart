import 'package:chatapp/src/constants/source_of_truth.dart';
import 'package:chatapp/src/utils/stream_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      //const MyApp(),
      const MaterialApp(
    home: FireBaseDemo(),
  ));
}

// Stream<List> watchMessages() => FirebaseFirestore.instance
//     .collection('chats/amAflxUTjTvrI261RJYi/messages')
//     .snapshots()
//     .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

// Stream<QuerySnapshot<Map<String, dynamic>>> returnCollectionSnapshot(
//         {required String collectionPath}) =>
//     FirebaseFirestore.instance.collection(collectionPath).snapshots();

// Stream<List<Map<String, dynamic>>> returnListDocsData(
//         {required Stream<QuerySnapshot<Map<String, dynamic>>> snapshot}) =>
//     snapshot.map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

// final testStream = returnListDocsData(
//     snapshot: returnCollectionSnapshot(
//         collectionPath: 'chats/amAflxUTjTvrI261RJYi/messages'));

class FireBaseDemo extends StatelessWidget {
  const FireBaseDemo({super.key});
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
            if (!snapshot.hasData) {
              return const SizedBox.shrink();
            }
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: ((context, index) {
                print(snapshot.data);
                return Container(
                  height: 110,
                  decoration: BoxDecoration(color: AppColor.main),
                  child: Center(
                    child: Text(
                      snapshot.data![0]['text'].toString(),
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
