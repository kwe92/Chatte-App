import 'package:flutter/material.dart';

// TODO: add comments

// TODO: refactor so you dont need so much context

// TODO: maybe use a switch statement that picks from a RegisterViews Enum and use a singleton to access the root context ? will this work?

class AppNavigator {
  Future<void> push(BuildContext context, Widget Function(BuildContext context) builder) async => await Navigator.of(context).push(
        MaterialPageRoute(builder: builder),
      );

  Future<void> pushReplacement(BuildContext context, Widget Function(BuildContext context) builder) async =>
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: builder),
      );

  void pop<T extends Object?>(BuildContext context, T? result) async => Navigator.of(context).pop(result);
}
