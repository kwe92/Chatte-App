import 'package:cloud_firestore/cloud_firestore.dart';

//TODO: Add UserName to the MessageModel to display to the chatscreen
class MessageModel {
  const MessageModel(
      {required this.userID, required this.textID, required this.text});
  final String userID;
  final String textID;
  final String text;
  Timestamp get _timeStamp => Timestamp.now();

  Map<String, dynamic> toJSON() {
    return {
      'userid': userID,
      'textid': textID,
      'text': text.trim(),
      'timestamp': _timeStamp,
    };
  }

  factory MessageModel.fromJSON(Map<String, dynamic> json) {
    return MessageModel(
      userID: json['userid'],
      textID: json['textid'],
      text: json['text'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MessageModel &&
        other.textID == textID &&
        other.text == text;
  }

  @override
  int get hashCode => textID.hashCode ^ text.hashCode;

  @override
  String toString() =>
      'MessageModel(userID: $userID, textID: $textID, text: $text)';
}
