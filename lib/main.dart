import 'package:chatapp/app/theme/theme.dart';
import 'package:chatapp/features/authentication/ui/sign_in_view.dart';
import 'package:chatapp/shared/services/get_it.dart';
import 'package:chatapp/shared/services/services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configureDependencies();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        navigatorKey: keyService.navigatorKey,
        scaffoldMessengerKey: keyService.scaffoldMessengerKey,
        theme: AppTheme.getTheme(),
        home: const SignInView(),
      ),
    );
  }
}
