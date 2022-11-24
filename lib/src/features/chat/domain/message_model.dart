import 'package:cloud_firestore/cloud_firestore.dart';

//TODO: Add UserName to the MessageModel to display to the chatscreen
class MessageModel {
  const MessageModel(
      {required this.userID,
      required this.userName,
      required this.textID,
      required this.text});
  final String userID;
  final String userName;
  final String textID;
  final String text;
  Timestamp get _timeStamp => Timestamp.now();

  Map<String, dynamic> toJSON() {
    return {
      'username': userName,
      'userid': userID,
      'textid': textID,
      'text': text.trim(),
      'timestamp': _timeStamp,
    };
  }

  factory MessageModel.fromJSON(Map<String, dynamic> json) {
    return MessageModel(
      userName: json['username'],
      userID: json['userid'],
      textID: json['textid'],
      text: json['text'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MessageModel &&
        other.userID == userID &&
        other.userName == userName &&
        other.textID == textID &&
        other.text == text;
  }

  @override
  int get hashCode {
    return userID.hashCode ^
        userName.hashCode ^
        textID.hashCode ^
        text.hashCode;
  }

  @override
  String toString() {
    return 'MessageModel(userID: $userID, userName: $userName, textID: $textID, text: $text)';
  }
}
