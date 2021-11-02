// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:blood_donation/components/filled_Button.dart';
import 'package:blood_donation/pages/home/home.dart';
import 'package:flutter/material.dart';

class Finished extends StatelessWidget {
  const Finished({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: new Scaffold(
        backgroundColor: Colors.white,
        body: new Padding(
          padding: EdgeInsets.all(20),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new Image.asset("assets/images/success.png"),
              new SizedBox(
                height: 100,
              ),
              new MyFilledButton(
                child: new Text("FINISH",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                  ),),
                size: new Size(double.infinity, 0),
                borderRadius: 50,
                function: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) {
                        return new MyHome();
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
