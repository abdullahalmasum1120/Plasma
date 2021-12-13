import 'package:blood_donation/components/constant/colors.dart';
import 'package:blood_donation/components/constant/size.dart';
import 'package:flutter/material.dart';

enum SendButtonState {
  visible,
  hidden,
}

class ChatInputField extends StatefulWidget {
  const ChatInputField({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  SendButtonState sendButtonState = SendButtonState.hidden;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(MySizes.defaultRadius * 4),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              maxLines: 2,
              minLines: 1,
              onChanged: (text) {
                if (text.isEmpty &&
                    (sendButtonState == SendButtonState.visible)) {
                  setState(() {
                    sendButtonState = SendButtonState.hidden;
                  });
                }
                if (text.isNotEmpty &&
                    (sendButtonState == SendButtonState.hidden)) {
                  setState(() {
                    sendButtonState = SendButtonState.visible;
                  });
                }
              },
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: "Type message",
                border: InputBorder.none,
                suffixIcon: Visibility(
                  visible: (sendButtonState == SendButtonState.visible),
                  child: IconButton(
                    onPressed: () {
                      //TODO: SendMessage()
                    },
                    icon: const Icon(
                      Icons.send,
                      color: MyColors.primary,
                    ),
                  ),
                ),
                prefixIcon: IconButton(
                  onPressed: () {
                    //TODO: pickImage()
                  },
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: (sendButtonState == SendButtonState.hidden),
            child: IconButton(
              onPressed: () {
                //TODO: voiceRecordSend()
              },
              icon: const Icon(
                Icons.mic,
                color: MyColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
