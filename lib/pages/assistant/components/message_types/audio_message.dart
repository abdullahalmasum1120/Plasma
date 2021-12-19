// ignore_for_file: prefer_const_constructors

import 'package:audioplayers/audioplayers.dart';
import 'package:blood_donation/components/constant/size.dart';
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
  late Stream stream;
  final AudioPlayer player = AudioPlayer();
  PlayerState playerState = PlayerState.PAUSED;
  Duration duration = Duration.zero;
  Duration progress = Duration.zero;

  @override
  void initState() {
    super.initState();
    player.onPlayerStateChanged.listen((PlayerState playerState) {
      if (this.playerState != playerState) {
        setState(() {
          this.playerState = playerState;
        });
      }
    });
    player.onAudioPositionChanged.listen((Duration progress) {
      setState(() {
        this.progress = progress;
      });
    });
    player.onDurationChanged.listen((Duration duration) {
      setState(() {
        this.duration = duration;
      });
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
      height: MySizes.defaultSpace * 2.3,
      width: MediaQuery.of(context).size.width * 0.55,
      padding: EdgeInsets.symmetric(
        horizontal: MySizes.defaultSpace,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color(0xFFFF2156).withOpacity(isSender ? 1 : 0.1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SliderTheme(
                data: SliderThemeData(
                  trackShape: CustomTrackShape(),
                  trackHeight: 2,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 4),
                ),
                child: Slider(
                  label:
                      "${(progress.inSeconds / 60).floor()} : ${progress.inSeconds % 60}",
                  value: progress.inSeconds.toDouble(),
                  max: duration.inSeconds.toDouble(),
                  thumbColor: isSender ? Colors.white : Color(0xFFFF2156),
                  onChanged: (position) {
                    setState(() {
                      progress = Duration(seconds: position.toInt());
                      player.seek(progress);
                    });
                  },
                ),
              ),
            ),
          ),
          Visibility(
            visible: (duration != Duration.zero),
            child: Text(
              "${(duration.inSeconds / 60).floor()} : ${duration.inSeconds % 60}",
              style: TextStyle(
                  fontSize: 12, color: isSender ? Colors.white : null),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTrackShape extends RectangularSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
