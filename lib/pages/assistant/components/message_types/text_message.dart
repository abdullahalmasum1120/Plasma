// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:blood_donation/model/assistant/chat_message.dart';
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
    print(isSender);
    return Container(
      ///error occurred
      // color: MediaQuery.of(context).platformBrightness == Brightness.dark
      //     ? Colors.white
      //     : Colors.black,
      padding: EdgeInsets.symmetric(
        horizontal: 20 * 0.75,
        vertical: 20 / 2,
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
    );
  }
}
