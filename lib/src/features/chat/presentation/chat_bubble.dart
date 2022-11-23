import 'package:flutter/material.dart';

//TODO: TextTile bubble? with a container?
//TODO: Change the color and positioning of the buble depending on who is logged in
//TODO: Show the current user and maybe a filler circular avatar for the user picture

class ChatBubble extends StatelessWidget {
  const ChatBubble({required this.text, required this.userID, super.key});
  final String text;
  final String userID;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          width: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Theme.of(context).primaryColor,
          ),
          child: Column(
            children: [
              Text(
                // msgModels[index].text,
                text,
                style: const TextStyle(fontSize: 18.0, color: Colors.white),
              ),
              Text(userID,
                  style: const TextStyle(fontSize: 8.0, color: Colors.white))
            ],
          ),
        ),
      ],
    );
  }
}
