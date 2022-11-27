import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  const MessageModel(
      {required this.userid,
      required this.username,
      required this.textID,
      required this.text});
  final String userid;
  final String username;
  final String textID;
  final String text;
  Timestamp get _timeStamp => Timestamp.now();

  Map<String, dynamic> toJSON() {
    return {
      'username': username,
      'userid': userid,
      'textid': textID,
      'text': text.trim(),
      'timestamp': _timeStamp,
    };
  }

  factory MessageModel.fromJSON(Map<String, dynamic> json) {
    return MessageModel(
      username: json['username'],
      userid: json['userid'],
      textID: json['textid'],
      text: json['text'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MessageModel &&
        other.userid == userid &&
        other.username == username &&
        other.textID == textID &&
        other.text == text;
  }

  @override
  int get hashCode {
    return userid.hashCode ^
        username.hashCode ^
        textID.hashCode ^
        text.hashCode;
  }

  @override
  String toString() {
    return 'MessageModel(userid: $userid, username: $username, textID: $textID, text: $text)';
  }
}
