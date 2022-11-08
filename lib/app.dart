import 'package:chatapp/src/constants/source_of_truth.dart';
import 'package:chatapp/src/features/chat/presentation/chat_screen.dart';
import 'package:flutter/material.dart';

const _title = 'Flutter CHat';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: AppColor.appBar),
      title: _title,
      home: const ChatScreen(title: _title),
    );
  }
}
