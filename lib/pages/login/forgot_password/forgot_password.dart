// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:blood_donation/components/filled_Button.dart';
import 'package:blood_donation/pages/login/login.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
        child: new Scaffold(
      backgroundColor: Colors.white,
      body: new Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          color: Colors.white,
          height: double.infinity,
          width: double.infinity,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  hintText: "Email",
                  fillColor: new Color(0xFFF8F8F8),
                  filled: true,
                  prefixIcon: new Icon(
                    Icons.email_outlined,
                    color: new Color(0xFFFF2156),
                  ),
                ),
              ),
              new SizedBox(
                height: 20,
              ),
              new Text(
                "Your password reset request will be send in your registered email address.",
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontSize: 18,
                  letterSpacing: 1.25,
                ),
              ),
              new SizedBox(
                height: 50,
              ),
              new MyFilledButton(
                child: new Text("SEND",
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
                        return new LogIn();
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    ));
  }
}
