import 'package:chatapp/features/authentication/ui/auth_view.dart';
import 'package:chatapp/features/create_user/presentation/create_user_screen.dart';
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
          // colorScheme: const ColorScheme.highContrastDark(),
          // buttonTheme: ButtonTheme.of(context).copyWith(
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(0)))
        ),
        title: _title,
        initialRoute: '/',
        //  '/chatscreen',
        routes: <String, WidgetBuilder>{
          '/': (context) => const AuthView(title: _title),
          // '/chatscreen': (context) => const ChatScreen(),
          '/createuser': (context) => const CreateScreen(),
        },
      ),
    );
  }
}
