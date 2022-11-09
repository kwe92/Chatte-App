import 'package:chatapp/src/constants/source_of_truth.dart';
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
          stream: FirebaseFirestore.instance
              .collection('chats/amAflxUTjTvrI261RJYi/messages')
              .snapshots(),
          builder: ((context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox.shrink();
            }
            return ListView.builder(
              itemCount: 6,
              itemBuilder: ((context, index) => Container(
                    height: 110,
                    decoration: BoxDecoration(color: AppColor.main),
                    child: Center(
                      child: Text(
                        snapshot.data.toString(),
                      ),
                    ),
                  )),
            );
          }),
        ),
      ),
    );
  }
}
