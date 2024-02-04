import 'package:flutter/material.dart';

class VisibilityIcon extends StatelessWidget {
  final bool isObscured;
  final VoidCallback setObscurity;

  const VisibilityIcon({
    required this.isObscured,
    required this.setObscurity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: setObscurity,
      icon: isObscured ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
    );
  }
}
