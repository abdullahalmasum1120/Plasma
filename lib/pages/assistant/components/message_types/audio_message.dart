// ignore_for_file: prefer_const_constructors

import 'package:blood_donation/components/constant/colors.dart';
import 'package:blood_donation/model/assistant/chat_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

enum PlayerState {
  playing,
  pause,
  idle,
}

class AudioMessage extends StatefulWidget {
  final ChatMessage chat;

  const AudioMessage({
    Key? key,
    required this.chat,
  }) : super(key: key);

  @override
  State<AudioMessage> createState() => _AudioMessageState();
}

class _AudioMessageState extends State<AudioMessage> {
  final AudioPlayer player = AudioPlayer();
  PlayerState playerState = PlayerState.idle;

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isSender =
        (widget.chat.sender == FirebaseAuth.instance.currentUser!.uid);
    // print(playerState);
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      padding: EdgeInsets.symmetric(
        horizontal: 20 * 0.75,
        vertical: 20 / 2.5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color(0xFFFF2156).withOpacity(isSender ? 1 : 0.1),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () async {
              //TODO: play();
              // player.setUrl(widget.chat.audio!);
              // if (playerState == PlayerState.playing) {
              //   player.pause();
              // } else {
              //   player.play();
              // }
            },
            child: (playerState == PlayerState.pause)
                ? Icon(
                    Icons.pause,
                    color: isSender ? Colors.white : Color(0xFFFF2156),
                  )
                : Icon(
                    Icons.play_arrow,
                    color: isSender ? Colors.white : Color(0xFFFF2156),
                  ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20 / 2),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: isSender
                        ? Colors.white
                        : Color(0xFFFF2156).withOpacity(0.4),
                  ),
                  Positioned(
                    left: 0,
                    child: Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color: isSender ? Colors.white : Color(0xFFFF2156),
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Text(
            "0.37",
            style:
                TextStyle(fontSize: 12, color: isSender ? Colors.white : null),
          ),
        ],
      ),
    );
  }
}
