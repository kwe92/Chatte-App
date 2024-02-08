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

  String? _imageFileName;

  Reference? _imageStorageRef;

  File? _pickedImage;

  String? get imageUrl => _imageUrl;

  String? get imageFileName => _imageFileName;

  File? get pickedImage => _pickedImage;

  void setMessage(String? message) {
    _message = message;
    notifyListeners();
  }

  Future<void> sendMessage(abs.User user) async {
    await runBusyFuture(() async {
      await uploadImageToFirebase();
      await chatService.sendMessage(
        user,
        _message!,
        collectionPath: CollectionPath.chat.path,
        messageImageUrl: _imageUrl,
        messageImageFileName: _imageFileName,
      );
    });

    if (_pickedImage != null || _imageUrl != null || _imageUrl!.isNotEmpty) {
      clearImageData();
    }
    messageController.clear();
  }

  Future<void> deleteMessage(Message message) async {
    await deleteMessageImage(message);
    await chatService.deleteMessage(message.textID, CollectionPath.chat.path);
  }

  Future<void> deleteMessageImage(Message message) async {
    if (message.messageImageFileName != null && message.messageImageFileName!.isNotEmpty) {
      final storageRef = firebaseService.storageInstance.ref().child(CollectionPath.images.path).child(message.messageImageFileName!);

      await storageRef.delete();
    }
  }

  Stream chatMessageStream() async* {
    yield* firestoreService.getAllDocuments(
      collectionPath: CollectionPath.chat.path,
      orderBy: 'timestamp',
    );
  }

  Future<void> pickImage(abs.User user) async {
    final (imageFile, _, error) = await imagePickerService.pickImage();

    if (error != null) {
      toastService.showSnackBar(ToastServiceErrorMessage.imageError);
      return;
    }

    _pickedImage = imageFile;

    _imageFileName = "${user.id}-${DateTime.now()}-messageImage.jpg";

    notifyListeners();
  }

  Future<void> uploadImageToFirebase() async {
    try {
      _imageStorageRef = await firebaseService.uploadImageToStorage(_imageFileName!, _pickedImage);
    } catch (e) {
      _imageFileName = null;
      debugPrint("exception in pickImage chat view: ${e.toString()}");
    }

    _imageUrl = await _imageStorageRef!.getDownloadURL();

    notifyListeners();
  }

  void clearImageData() {
    _imageUrl = null;
    _pickedImage = null;
    _imageFileName = null;
    _imageStorageRef = null;
    notifyListeners();
  }
}
