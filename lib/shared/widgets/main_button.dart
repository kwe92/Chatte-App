import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final VoidCallback onPressed;
  final EdgeInsets contentPadding;
  final Widget child;
  final double buttonWidth;

  const MainButton({
    required this.onPressed,
    required this.child,
    this.contentPadding = const EdgeInsets.symmetric(vertical: 16.0),
    this.buttonWidth = double.maxFinite,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Padding(
          padding: contentPadding,
          child: child,
        ),
      ),
    );
  }
}
