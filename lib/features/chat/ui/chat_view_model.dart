import 'dart:io';

import 'package:chatapp/app/general/constants.dart';
import 'package:chatapp/shared/models/message.dart';
import 'package:chatapp/shared/models/user.dart' as abs;
import 'package:chatapp/shared/services/services.dart';
import 'package:chatapp/shared/utils/classes/extended_change_notifier.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ChatViewModel extends ExtendedChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final TextEditingController messageController = TextEditingController();

  String? _message = '';

  String? _imageUrl;

  Reference? _imageStorageRef;

  File? _pickedImage;

  String? get imageUrl => _imageUrl;

  File? get pickedImage => _pickedImage;

  void setMessage(String? message) {
    _message = message;
    notifyListeners();
  }

  Future<void> sendMessage(abs.User user) async {
    await runBusyFuture(
      () => chatService.sendMessage(user, _message!, CollectionPath.chat.path, _imageUrl),
    );

    if (_pickedImage != null || _imageUrl != null || _imageUrl!.isNotEmpty) {
      clearImageData();
    }
    messageController.clear();
  }

  Future<void> deleteMessage(Message message) async {
    if (message.messageImageUrl != null || message.messageImageUrl!.isNotEmpty) {
      // TODO: use the name of the image file
      final storageRef = firebaseService.storageInstance.ref(message.messageImageUrl);
      await storageRef.delete();
    }
    await chatService.deleteMessage(message.textID, CollectionPath.chat.path);
  }

  Stream chatMessageStream() async* {
    yield* firestoreService.getAllDocuments(
      collectionPath: CollectionPath.chat.path,
      orderBy: 'timestamp',
    );
  }

  Future<void> clearImage() async {
    await runBusyFuture(
      () => _imageStorageRef!.delete(),
    );
    clearImageData();
  }

  // TODO: refactor to only upload image if user sends message
  // TODO: refactor setBusy
  Future<void> pickImage(abs.User user) async {
    final (imageFile, _, error) = await runBusyFuture<(File?, bool, String?)>(() => imagePickerService.pickImage());

    if (error != null) {
      toastService.showSnackBar("image maybe corrupted, please try another image.");
      return;
    }

    try {
      _imageStorageRef = await firebaseService.uploadImageToStorage("${user.id}-${DateTime.now()}-messageImage", imageFile);
    } catch (e) {
      debugPrint("exception in pickImage chat view: ${e.toString()}");
    }

    _pickedImage = imageFile;

    _imageUrl = await _imageStorageRef!.getDownloadURL();

    notifyListeners();
  }

  void clearImageData() {
    _imageUrl = null;
    _pickedImage = null;
    notifyListeners();
  }
}
