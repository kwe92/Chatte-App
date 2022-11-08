import 'package:chatapp/src/constants/source_of_truth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({required this.title, super.key});
  final String title;
  @override
  Widget build(BuildContext context) {
    var _i = 0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backGround,
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView.builder(
          itemCount: 8,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 110,
              decoration: BoxDecoration(color: AppColor.main),
              child: Center(child: Text('Dummy text ${_i++}')),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple[200],
          onPressed: () {},
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
