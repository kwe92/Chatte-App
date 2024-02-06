import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Message {
  final String userid;
  final String username;
  final String userImageUrl;
  final String textID;
  final String text;
  final String? messageImageUrl;

  Timestamp get timeStamp;

  const Message({
    required this.userid,
    required this.username,
    required this.userImageUrl,
    required this.textID,
    required this.text,
    this.messageImageUrl,
  });

  Map<String, dynamic> toJSON();
}
