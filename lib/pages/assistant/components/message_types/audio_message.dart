// ignore_for_file: prefer_const_constructors

import 'package:audioplayers/audioplayers.dart';
import 'package:blood_donation/model/assistant/chat_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  PlayerState playerState = PlayerState.PAUSED;
  Duration duration = Duration(seconds: 150);

  // double position = 0;

  @override
  void initState() {
    super.initState();
    player.onPlayerStateChanged.listen((PlayerState state) {
      if (playerState != state) {
        setState(() {
          playerState = state;
        });
      }
    });
  }

  @override
  void dispose() {
    player.release();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isSender =
        (widget.chat.sender == FirebaseAuth.instance.currentUser!.uid);
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      padding: EdgeInsets.symmetric(
        horizontal: 20 * 0.75,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color(0xFFFF2156).withOpacity(isSender ? 1 : 0.1),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (playerState == PlayerState.PLAYING) {
                player.pause();
              } else {
                player.play(widget.chat.audio!);
              }
            },
            child: (playerState == PlayerState.PLAYING)
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
            child: Slider(
              value: 0,
              max: duration.inSeconds.toDouble(),
              thumbColor: isSender ? Colors.white : Color(0xFFFF2156),
              onChanged: (position) {},
            ),
          ),
          Text(
            "${(duration.inSeconds / 60).floor()} : ${duration.inSeconds % 60}",
            style:
                TextStyle(fontSize: 12, color: isSender ? Colors.white : null),
          ),
        ],
      ),
    );
  }
}
