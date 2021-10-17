// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ChatInputField extends StatelessWidget {
  const ChatInputField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -10),
            blurRadius: 32,
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            new IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.camera_alt_outlined,
                color: Colors.black,
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: new Color(0xFFFF2156).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    new IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.mic,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Type message",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    new IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.sentiment_satisfied_alt_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            new IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.send,
                color: new Color(0xFFFF2165),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
