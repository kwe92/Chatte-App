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
            shape: resolver(
              (states) => const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
            ),
            backgroundColor: resolver(
              (states) => AppColor.primaryThemeColor,
            ),
            textStyle: resolver(
              (states) => TextStyle(
                foreground: Paint()..color = Colors.white,
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
      // TODO: change to a darker grey
      color: AppColor.grey0,
    ),
  );
}();

MaterialStateProperty<T> resolver<T>(T Function(Set<MaterialState> states) callback) {
  return MaterialStateProperty.resolveWith<T>(callback);
}

// TODO: Notes on ColorScheme
