// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';

class LastPageView extends StatelessWidget {
  const LastPageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 250,
            color: Colors.white,
            child: new Image.asset(
              "assets/images/intro_two.png",
              fit: BoxFit.cover,
            ),
          ),
          new SizedBox(
            height: 50,
          ),
          new Text(
            "Post a blood Request",
            style: new TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.50,
            ),
          ),
          new SizedBox(
            height: 20,
          ),
          new Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Arcu tristique tristique quam in.",
            style: new TextStyle(
              fontSize: 18,
              letterSpacing: 1.25,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
    ;
  }
}
