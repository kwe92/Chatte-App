import 'package:flutter/material.dart';

List<Widget>? logoutButton({required BuildContext context}) => [
      Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: TextButton.icon(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/');
          },
          icon: const Icon(Icons.menu),
          label: const Text(
            'Logout',
            style: TextStyle(color: Colors.white),
          ),
        ),
      )
    ];
