import 'package:chatapp/shared/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserMessage extends Message {
  @override
  Timestamp get timeStamp => Timestamp.now();

  const UserMessage({
    required super.userid,
    required super.username,
    required super.userImageUrl,
    required super.textID,
    required super.text,
    super.messageImageUrl,
  });

  @override
  Map<String, dynamic> toJSON() {
    return {
      'username': username,
      'userid': userid,
      'userimage': userImageUrl,
      'message_image': messageImageUrl,
      'textid': textID,
      'text': text.trim(),
      'timestamp': timeStamp,
    };
  }

  /// Create a [UserMessage] from a json object
  factory UserMessage.fromJSON(Map<String, dynamic> json) {
    return UserMessage(
      username: json['username'],
      userid: json['userid'],
      userImageUrl: json['userimage'],
      messageImageUrl: json['message_image'],
      textID: json['textid'],
      text: json['text'],
    );
  }

  @override
  String toString() {
    return 'UserMessage(userid: $userid, username: $username, userImageUrl: $userImageUrl, messageImageUrl: $messageImageUrl, textID: $textID, text: $text)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserMessage &&
        other.userid == userid &&
        other.username == username &&
        other.userImageUrl == userImageUrl &&
        other.textID == textID &&
        other.text == text;
  }

  @override
  int get hashCode {
    return userid.hashCode ^ username.hashCode ^ userImageUrl.hashCode ^ textID.hashCode ^ text.hashCode;
  }
}
