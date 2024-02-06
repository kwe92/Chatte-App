import 'package:chatapp/shared/models/message.dart';
import 'package:chatapp/shared/models/user.dart';
import 'package:flutter/material.dart';

TextStyle chatTextStyle({
  required User currentUser,
  required Message message,
  required context,
  Color? color,
  double fontSize = 14.0,
  FontWeight? weight = FontWeight.bold,
}) =>
    currentUser.id == message.userid
        ? TextStyle(fontSize: fontSize, color: color ?? Colors.white, fontWeight: weight)
        : TextStyle(fontSize: fontSize, color: color ?? Theme.of(context).primaryColor, fontWeight: weight);
