import 'package:chatapp/app/theme/theme.dart';
import 'package:chatapp/features/authentication/ui/sign_in_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ProviderScope(
        child: MaterialApp(
          theme: AppTheme.getTheme(),
          initialRoute: '/',
          routes: <String, WidgetBuilder>{
            '/': (context) => const SignInView(),
          },
        ),
      );
}
