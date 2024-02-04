import 'package:chatapp/shared/models/user.dart';
import 'package:chatapp/app/providers/chats_provider.dart';
import 'package:chatapp/app/utils/validator.dart';
import 'package:chatapp/shared/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SendMessage extends StatefulWidget {
  final User user;

  const SendMessage({required this.user, super.key});

  @override
  State<SendMessage> createState() => _SendMessageState();
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
        //Typing field
        Expanded(
          child: Form(
            key: _formKey,
            child: TextFormField(
              controller: messageController,
              // Validators
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
        Consumer(
          builder: ((context, ref, _) => IconButton(
                onPressed: () {
                  // If validation passes send message
                  if (Validator.trySubmit(_formKey)) {
                    final collectionPath = ref.read(chatProvider.notifier).state;
                    final newMsg = messageController.text;
                    chatService.sendMessage(widget.user, newMsg, collectionPath);
                    // debugPrint(newMsg);
                    messageController.clear();
                  }
                },
                icon: const Icon(
                  Icons.send,
                  // color: Theme.of(context).primaryColor,
                ),
              )),
        )
      ]),
    );
  }
}
