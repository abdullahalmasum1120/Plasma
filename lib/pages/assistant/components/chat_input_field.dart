import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:blood_donation/components/constant/colors.dart';
import 'package:blood_donation/components/constant/size.dart';
import 'package:blood_donation/model/assistant/chat_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:record/record.dart';

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
  final String myAudioPath = 'storage/emulated/0/Download/audio.mp3';

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.grey.withOpacity(0.1),
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
                        String docId = const Uuid().v1();
                        sendMessage(
                          docId: docId,
                          user: FirebaseAuth.instance.currentUser!,
                          text: messageController.text.trim(),
                          messageType: "text",
                        ).then((value) => FirebaseFirestore.instance
                            .collection("assistant")
                            .doc(docId)
                            .update({"messageStatus": "notViewed"}));
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
                  onPressed: () async {
                    try {
                      XFile? file = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (file != null) {
                        Get.snackbar("Message", "sending...");
                        uploadFile(File(file.path), "image"); //uploading
                      }
                    } on FirebaseException catch (e) {
                      Get.snackbar("Warning!", e.code);
                    }
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
            child: GestureDetector(
              onLongPressStart: (details) async {
                if (await Record().hasPermission()) {
                  await Record().start(path: myAudioPath);
                }
              },
              onLongPressEnd: (details) async {
                await Record().stop();
                uploadFile(File(myAudioPath), "audio");
              },
              child: IconButton(
                icon: const Icon(
                  Icons.mic,
                  color: MyColors.black,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> sendMessage({
    required String docId,
    required User user,
    required String messageType,
    String? text,
    String? image,
  }) async {
    // print(DateTime.utc(year).millisecond);
    ChatMessage chatMessage = ChatMessage(
      messageType: messageType,
      messageStatus: "notSent",
      sender: user.uid,
      senderName: user.displayName,
      senderProfileImage: user.photoURL,
      text: text,
      docId: docId,
      image: image,
      timeStamp: DateTime.now().millisecondsSinceEpoch.toString(),
      time: DateFormat('kk:mm').format(DateTime.now()),
      date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
    );
    await FirebaseFirestore.instance
        .collection("assistant")
        .doc(docId)
        .set(chatMessage.toJson());
  }

  void uploadFile(File file, String messageType) async {
    String? docId = const Uuid().v1();
    sendMessage(
        docId: docId,
        user: FirebaseAuth.instance.currentUser!,
        messageType: messageType);

    Reference reference = FirebaseStorage.instance
        .ref("assistant")
        .child(messageType)
        .child("$docId.${path.extension(file.path)}");
    await reference.putFile(File(file.path));

    FirebaseFirestore.instance.collection("assistant").doc(docId).update({
      messageType: await reference.getDownloadURL(),
      "messageStatus": "notViewed",
    });
  }
}
