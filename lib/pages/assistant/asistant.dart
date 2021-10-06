// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:blood_donation/pages/assistant/components/chat_input_field.dart';
import 'package:blood_donation/pages/assistant/components/message.dart';
import 'package:blood_donation/pages/assistant/components/model/chat_message.dart';
import 'package:flutter/material.dart';

class Assistant extends StatelessWidget {
  const Assistant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          leading: new IconButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: new Icon(Icons.arrow_back_ios),
          ),
          backgroundColor: Colors.white,
          title: new Text(
            "Assistant",
            style: new TextStyle(
              color: new Color(0xFFFF2156),
              fontSize: 24,
            ),
          ),
          actions: [
            new IconButton(
              color: new Color(0xFFFF2156),
              onPressed: () {},
              icon: new Icon(Icons.help),
            ),
          ],
        ),
        body: new Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: new Column(
            children: [
              new Expanded(
                child: new ListView.builder(
                  itemCount: demeChatMessages.length,
                  itemBuilder: (context, index) {
                    return new Message(message: demeChatMessages[index]);
                  },
                ),
              ),
              new ChatInputField(),
            ],
          ),
        ),
      ),
    );
  }
}
