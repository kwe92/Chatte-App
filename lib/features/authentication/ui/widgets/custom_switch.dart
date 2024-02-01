import 'package:chatapp/app/theme/colors.dart';
import 'package:chatapp/app/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;

  final Function(bool value)? onChanged;

  const CustomSwitch({
    required this.value,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.65,
      child: Switch(
        value: value,
        onChanged: onChanged,
        inactiveThumbColor: AppColor.primaryThemeColor,
        trackOutlineColor: materialStatePropertyAdapter(AppColor.primaryThemeColor),
      ),
    );
  }
}


// Changing The Size of a Switch

//   you can shrink the size of a Switch by scaling it down using a Transform Widget