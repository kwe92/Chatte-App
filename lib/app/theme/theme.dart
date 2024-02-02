import 'package:chatapp/app/theme/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData getTheme() => ThemeData(
        colorScheme: const ColorScheme.light(
          primary: AppColor.primaryThemeColor,
        ),
        inputDecorationTheme: inputDecorationTheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: materialStatePropertyAdapter(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
            ),
            backgroundColor: materialStatePropertyAdapter(
              AppColor.primaryThemeColor,
            ),
            textStyle: materialStatePropertyAdapter(
              TextStyle(
                foreground: Paint()..color = Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
}

final InputDecorationTheme inputDecorationTheme = () {
  const sharedInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(
      color: AppColor.grey0,
      width: 1,
    ),
  );
  return const InputDecorationTheme(
    enabledBorder: sharedInputBorder,
    focusedBorder: sharedInputBorder,
    focusedErrorBorder: sharedInputBorder,
    errorBorder: sharedInputBorder,
    floatingLabelStyle: TextStyle(
      color: AppColor.grey0,
    ),
  );
}();

/// A convenience method to shorten calls to [MaterialStateProperty.resolveWith].
///
/// Converts an [Object] of type [T] to a [MaterialStateProperty] of type [T]
MaterialStateProperty<T> materialStatePropertyAdapter<T extends Object>(T object) =>
    MaterialStateProperty.resolveWith<T>((states) => object);

// TODO: Notes on ColorScheme

// TODO: notes on Adapters
