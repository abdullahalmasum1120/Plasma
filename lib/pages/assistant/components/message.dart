// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:blood_donation/components/constant/size.dart';
import 'package:blood_donation/pages/assistant/components/model/chat_message.dart';
import 'package:flutter/material.dart';
import 'message_types/audio_message.dart';
import 'message_types/text_message.dart';
import 'message_types/video_message.dart';

class Message extends StatelessWidget {
  final ChatMessage message;

  const Message({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget messageContained(ChatMessage message) {
      switch (message.messageType) {
        case ChatMessageType.text:
          return new TextMessage(message: message);
        case ChatMessageType.audio:
          return new AudioMessage(message: message);
        case ChatMessageType.video:
          return new VideoMessage();
        default:
          return new SizedBox();
      }
    }

    return new Padding(
      padding: EdgeInsets.only(
        top: MySizes.defaultSpace / 2,
      ),
      child: new Row(
        mainAxisAlignment:
            message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isSender) ...[
            new CircleAvatar(
              radius: 16,
              // backgroundImage: new AssetImage(""),
            ),
            new SizedBox(
              width: MySizes.defaultSpace / 2,
            ),
          ],
          messageContained(message),
          if (message.isSender)
            new MessageStatusDot(status: message.messageStatus)
        ],
      ),
    );
  }
}

class MessageStatusDot extends StatelessWidget {
  final MessageStatus? status;

  const MessageStatusDot({Key? key, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color dotColor(MessageStatus status) {
      switch (status) {
        case MessageStatus.not_sent:
          return Colors.red;
        case MessageStatus.not_view:
          return Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.1);
        case MessageStatus.viewed:
          return new Color(0xFFFF2156);
        default:
          return Colors.transparent;
      }
    }

    return new Container(
      margin: EdgeInsets.only(
        left: 10,
      ),
      height: 12,
      width: 12,
      decoration: new BoxDecoration(
        color: dotColor(status!),
        shape: BoxShape.circle,
      ),
      child: new Icon(
        status == MessageStatus.not_sent ? Icons.close : Icons.done,
        size: 8,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
