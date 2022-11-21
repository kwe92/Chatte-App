import 'package:chatapp/src/constants/source_of_truth.dart';
import 'package:chatapp/src/features/authentication/presentation/auth_form.dart';
import 'package:chatapp/src/features/authentication/presentation/auth_screen.dart';
import 'package:chatapp/src/features/chat/presentation/chat_screen.dart';
import 'package:chatapp/src/features/create_user/create_form.dart';
import 'package:chatapp/src/features/create_user/create_user_screem.dart';
import 'package:flutter/material.dart';

const _title = 'Flutter CHat';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: AppColor.appBar),
      title: _title,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => AuthScreen(body: AuthForm(
              onPressed: () {
                Navigator.pushNamed(context, '/createuser');
              },
            )),
        '/chatscreen': (context) => const ChatScreen(title: _title),
        '/createuser': (context) => const CreateScreen(body: CreateForm()),
      },
    );
  }
}
