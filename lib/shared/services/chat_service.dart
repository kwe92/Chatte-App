import 'package:chatapp/features/chat/domain/message_model.dart';
import 'package:chatapp/shared/models/base_user.dart';
import 'package:chatapp/shared/services/services.dart';

class ChatService {
  // Delete a message given the currently logged in user
  Future<void> deleteMessage({required String id, required String path}) async {
    final docUsers = firestoreService.instance.collection(path).doc(id);
    await docUsers.delete();
  }

  // Send a message by current user
  void sendMessage(AbstractUser user, String text, String path) {
    final colRef = firestoreService.instance.collection(path);
    final textID = colRef.doc().id;
    MessageModel newMessage = MessageModel(
      userid: user.id,
      username: user.username,
      userImageUrl: user.url,
      textID: textID,
      text: text,
    );
    colRef.doc(textID).set(
          newMessage.toJSON(),
        );
  }
}
