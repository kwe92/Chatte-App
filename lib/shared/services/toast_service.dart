import 'package:chatapp/shared/services/services.dart';
import 'package:chatapp/shared/utils/classes/popup_menu_parameters.dart';
import 'package:flutter/material.dart';

class ToastService {
  void showSnackBar(String message, [BuildContext? context]) {
    final snackBar = _getSnackBar(message);
    context == null
        ? keyService.scaffoldMessengerKey.currentState!.showSnackBar(
            snackBar,
          )
        : ScaffoldMessenger.of(context).showSnackBar(
            snackBar,
          );
  }

  // TODO: implement popupMenu

  Future<T> pupupMenu<T>(
    BuildContext context, {
    required PopupMenuParameters popupMenuParameters,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(popupMenuParameters.title),
        );
      },
    );
  }
}

SnackBar _getSnackBar(String message) => SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 12.0,
      ),
      content: Center(
        child: FittedBox(
          child: Text(
            message,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
