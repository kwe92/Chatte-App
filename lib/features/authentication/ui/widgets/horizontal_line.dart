import 'package:chatapp/app/theme/colors.dart';
import 'package:flutter/material.dart';

class HorizontalLine extends StatelessWidget {
  final Color color;

  final int flex;

  final double height;

  const HorizontalLine({
    this.color = AppColor.offWhite,
    this.flex = 1,
    this.height = 1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        height: height,
        color: color,
      ),
    );
  }
}
