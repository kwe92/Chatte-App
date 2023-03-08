import 'package:chatapp/src/constants/source_of_truth.dart';
import 'package:chatapp/src/features/authentication/presentation/auth_screen.dart';
import 'package:chatapp/src/features/chat/presentation/chat_screen.dart';
import 'package:chatapp/src/features/create_user/presentation/create_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _title = 'Convertir';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.amber,
          colorScheme: ColorScheme.highContrastDark(),
          // buttonTheme: ButtonTheme.of(context).copyWith(
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(0)))
        ),
        title: _title,
        initialRoute: '/',
        //  '/chatscreen',
        routes: <String, WidgetBuilder>{
          '/': (context) => const AuthScreen(title: _title),
          '/chatscreen': (context) => const ChatScreen(title: _title),
          '/createuser': (context) => const CreateScreen(),
        },
      ),
    );
  }
}
