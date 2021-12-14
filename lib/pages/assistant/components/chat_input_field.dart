import 'package:blood_donation/components/constant/colors.dart';
import 'package:blood_donation/components/constant/size.dart';
import 'package:blood_donation/model/assistant/chat_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

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
  TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

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
              controller: messageController,
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
                      if (messageController.text.isNotEmpty) {
                        sendMessage(
                          const Uuid().v1(),
                          FirebaseAuth.instance.currentUser!,
                          messageController.text.trim(),
                        );
                        messageController.text = "";
                      }
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

  void sendMessage(String docId, User user, String text) {
    ChatMessage chatMessage = ChatMessage(
      messageType: "text",
      messageStatus: "notSent",
      sender: user.uid,
      senderName: user.displayName,
      senderProfileImage: user.photoURL,
      text: text,
      docId: docId,
      time: DateFormat('kk:mm').format(DateTime.now()),
      date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
    );
    FirebaseFirestore.instance
        .collection("assistant")
        .doc(docId)
        .set(chatMessage.toJson())
        .then((value) => FirebaseFirestore.instance
            .collection("assistant")
            .doc(docId)
            .update({"messageStatus": "notViewed"}));
  }
}
