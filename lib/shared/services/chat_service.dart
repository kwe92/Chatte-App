import 'package:chatapp/shared/models/message.dart';
import 'package:chatapp/shared/models/user_message.dart';
import 'package:chatapp/shared/models/user.dart';
import 'package:chatapp/shared/services/services.dart';

class ChatService {
  // Delete a message given the currently logged in user
  Future<void> deleteMessage(String id, String collectionPath) async {
    final docUsers = firestoreService.instance.collection(collectionPath).doc(id);
    await docUsers.delete();
  }

  // Send a message by current user
  Future<void> sendMessage(User user, String text, String collectionPath) async {
    final colRef = firestoreService.instance.collection(collectionPath);
    final textID = colRef.doc().id;
    Message newMessage = UserMessage(
      userid: user.id,
      username: user.username,
      userImageUrl: user.url,
      textID: textID,
      text: text,
    );
    await colRef.doc(textID).set(
          newMessage.toJSON(),
        );
  }
}
