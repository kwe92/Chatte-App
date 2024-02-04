import 'package:chatapp/shared/models/message.dart';
import 'package:chatapp/shared/models/user_message.dart';
import 'package:chatapp/shared/models/user.dart';
import 'package:chatapp/shared/services/services.dart';

class ChatService {
  // Delete a message given the currently logged in user
  Future<void> deleteMessage({required String id, required String path}) async {
    final docUsers = firestoreService.instance.collection(path).doc(id);
    await docUsers.delete();
  }

  // Send a message by current user
  void sendMessage(User user, String text, String path) {
    final colRef = firestoreService.instance.collection(path);
    final textID = colRef.doc().id;
    Message newMessage = UserMessage(
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
