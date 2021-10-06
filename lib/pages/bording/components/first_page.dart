// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:flutter/material.dart';

class FirstPageView extends StatelessWidget {
  const FirstPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.white,
              height: 250,
              width: double.infinity,
              child: new Image.asset(
                "assets/images/intro_one.png",
                fit: BoxFit.cover,
              ),
            ),
            new SizedBox(
              height: 50,
            ),
            new Text(
              "Find blood donors",
              textAlign: TextAlign.center,
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
      ),
    );
  }
}
