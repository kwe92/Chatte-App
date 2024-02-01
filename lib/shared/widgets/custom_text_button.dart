import 'package:chatapp/app/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final EdgeInsets padding;

  const CustomTextButton({
    required this.onPressed,
    required this.child,
    this.padding = const EdgeInsets.all(0),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: materialStatePropertyAdapter(
          padding,
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
