import 'package:blood_donation/components/constant/colors.dart';
import 'package:blood_donation/components/constant/size.dart';
import 'package:blood_donation/components/constant/styles.dart';
import 'package:blood_donation/pages/assistant/components/chat_input_field.dart';
import 'package:blood_donation/pages/assistant/components/message.dart';
import 'package:blood_donation/pages/assistant/components/model/chat_message.dart';
import 'package:flutter/material.dart';

class Assistant extends StatelessWidget {
  const Assistant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: MyColors.primary),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: MyColors.white,
        title: Text(
          "Assistant",
          style: MyTextStyles(MyColors.primary).titleTextStyle,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: MySizes.defaultSpace / 2,
              ),
              itemCount: demoChatMessages.length,
              itemBuilder: (context, index) {
                return Message(message: demoChatMessages[index]);
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(MySizes.defaultSpace / 4),
            child: ChatInputField(),
          ),
        ],
      ),
    );
  }
}
