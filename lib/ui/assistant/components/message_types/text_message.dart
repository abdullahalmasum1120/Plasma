// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:blood_donation/data/model/assistant/chat_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TextMessage extends StatelessWidget {
  final ChatMessage chat;

  const TextMessage({
    Key? key,
    required this.chat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSender = (chat.sender == FirebaseAuth.instance.currentUser!.uid);
    return Flexible(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: new Color(0xFFFF2156).withOpacity(isSender ? 1 : 0.1),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          chat.text!,
          style: TextStyle(
            color: isSender
                ? Colors.white
                : Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
      ),
    );
  }
}
