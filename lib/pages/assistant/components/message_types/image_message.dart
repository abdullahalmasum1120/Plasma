// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:blood_donation/components/constant/colors.dart';
import 'package:blood_donation/data/model/assistant/chat_message.dart';
import 'package:flutter/material.dart';

class ImageMessage extends StatelessWidget {
  final ChatMessage chat;

  const ImageMessage({
    Key? key,
    required this.chat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45, // 45% of total width
      child: AspectRatio(
        aspectRatio: 1.6,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: (chat.image != null)
                  ? Image.network(chat.image!)
                  : Image.asset("assets/images/video_place.png"),
            ),
            (chat.image == null)
                ? CircularProgressIndicator(
                    color: MyColors.primary,
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
