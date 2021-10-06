// ignore_for_file: unnecessary_new, prefer_const_constructors, file_names

import 'package:flutter/material.dart';

class MyFilledButton extends StatelessWidget {
  final String text;
  final Size size;
  final VoidCallback function;
  final double borderRadius;

  const MyFilledButton({
    Key? key,
    required this.text,
    required this.size,
    required this.function,
    required this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: size,
        padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
        primary: new Color(0xFFFF2156),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      onPressed: function,
      child: new Text(
        text,
        style: new TextStyle(
          color: Colors.white,
          fontSize: 20,
          letterSpacing: 1.2,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
