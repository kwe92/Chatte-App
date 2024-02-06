import 'package:flutter/material.dart';

class CircleWidget extends StatelessWidget {
  final double size;
  final Color backgroundColor;
  final Widget child;
  final Color? borderColor;
  final double? borderWidth;
  const CircleWidget({
    required this.size,
    required this.backgroundColor,
    required this.child,
    this.borderColor,
    this.borderWidth,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(size / 2),
        ),
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: borderWidth ?? 0.0,
        ),
      ),
      child: Center(child: child),
    );
  }
}
