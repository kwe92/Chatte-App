import 'package:chatapp/features/authentication/ui/sign_in_view.dart';
import 'package:chatapp/shared/services/services.dart';
import 'package:flutter/material.dart';

List<Widget>? logoutButton({required BuildContext context}) => [
      Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: TextButton.icon(
          onPressed: () async => await appNavigator.pushReplacement(const SignInView()),
          icon: const Icon(Icons.menu),
          label: const Text(
            'Logout',
            style: TextStyle(color: Colors.white),
          ),
        ),
      )
    ];
