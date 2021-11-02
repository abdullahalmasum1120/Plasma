// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: new RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 40,
        ),
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new CircularProgressIndicator(
              color: new Color(0xFFFF2156),
            ),
            new SizedBox(
              height: 20,
            ),
            new Text("Loading"),
          ],
        ),
      ),
    );
  }
}
