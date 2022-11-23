import 'package:chatapp/src/features/chat/domain/message_model.dart';
import 'package:chatapp/src/utils/validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SendMessage extends StatefulWidget {
  const SendMessage({required this.userID, super.key});
  final String userID;

  @override
  State<SendMessage> createState() => _SendMessageState();
}

void _sendMessage(String userID, String text,
    CollectionReference<Map<String, dynamic>> colRef) {
  final textID = colRef.doc().id;
  MessageModel newMessage =
      MessageModel(userID: userID, textID: textID, text: text);
  colRef.doc(textID).set(newMessage.toJSON());
}

class _SendMessageState extends State<SendMessage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.all(8.0),
      child: Row(children: <Widget>[
        Expanded(
          child: Form(
            key: _formKey,
            child: TextFormField(
              controller: messageController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Messsage can't be empty";
                }
                if (value.length > 150) {
                  return "Needs to be less than 150 characters";
                }
                return null;
              },
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: 'Send a message'),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            if (Validator.trySubmit(_formKey)) {
              final colRef = FirebaseFirestore.instance
                  .collection('/chat/3Rzps9JekqBlFfihf2Jq/messages');
              final newMsg = messageController.text;
              _sendMessage(widget.userID, newMsg, colRef);
              // debugPrint(newMsg);
              messageController.clear();
            }
          },
          icon: Icon(
            Icons.send,
            color: Theme.of(context).primaryColor,
          ),
        )
      ]),
    );
  }
}
