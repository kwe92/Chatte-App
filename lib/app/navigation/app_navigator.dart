import 'package:chatapp/shared/services/services.dart';
import 'package:flutter/material.dart';

/// API to add and remove routes from the route stack.
class AppNavigator {
  /// Push the given view onto the route stack.
  Future<void> push<T extends Widget>(T view) async => await keyService.navigatorKey.currentState!.push(
        MaterialPageRoute(
          builder: (context) => view,
        ),
      );

  /// Push the given view onto the route stack requiring a build context.
  Future<void> pushWithContext(BuildContext context, Widget Function(BuildContext context) builder) async =>
      await Navigator.of(context).push(
        MaterialPageRoute(builder: builder),
      );

  /// Replace current route with new view removing the current view from the route stack.
  Future<void> pushReplacement<T extends Widget>(T view) async => await keyService.navigatorKey.currentState!.pushReplacement(
        MaterialPageRoute(
          builder: (context) => view,
        ),
      );

  /// Replace current route with new view removing the current view from the route stack requiring a build context
  Future<void> pushReplacementWithContext(BuildContext context, Widget Function(BuildContext context) builder) async =>
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: builder),
      );

  /// Pop current route off of the navigator, optionally returning a calue back to the view that pushed the route onto the stack.
  void pop<T extends Object?>(T? result) async => keyService.navigatorKey.currentState!.pop(result);

  /// Pop current route off of the navigator, optionally returning a calue back to the view that pushed the route onto the stack requiring a build context.
  void popWithContext<T extends Object?>(BuildContext context, T? result) async => Navigator.of(context).pop(result);
}
