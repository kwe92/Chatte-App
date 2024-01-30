import 'package:flutter/material.dart';

// TODO: add comments

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
