import 'package:chatapp/app/general/constants.dart';
import 'package:chatapp/shared/models/user.dart' as abs;
import 'package:chatapp/shared/services/services.dart';
import 'package:flutter/material.dart';

class ChatViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final TextEditingController messageController = TextEditingController();

  String? _message = '';

  String? get nessage => _message;

  void setMessage(String? message) {
    _message = message;
    notifyListeners();
  }

  void sendMessage(abs.User user) {
    chatService.sendMessage(user, _message!, CollectionPath.chat.path);

    messageController.clear();
  }

  Stream chatMessageStream() async* {
    yield* firestoreService.getAllDocuments(
      collectionPath: CollectionPath.chat.path,
      orderBy: 'timestamp',
    );
  }
}
