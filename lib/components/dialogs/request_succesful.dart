// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuccessfulDialog extends StatelessWidget {
  const SuccessfulDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Dialog(
      backgroundColor: Colors.white,
      shape: new RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      insetPadding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 40,
      ),
      child: new SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 20,
          ),
          child: new Column(
            children: [
              new ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: new Image.asset(
                  "assets/images/request_success.png",
                  fit: BoxFit.cover,

                ),
              ),
              new SizedBox(
                height: 50,
              ),
              new Text(
                "Blood is SuccessFully Requested",
                textAlign: TextAlign.center,
                style: new TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.50,
                ),
              ),
              new SizedBox(
                height: 20,
              ),
              new Container(
                decoration: new BoxDecoration(
                  color: new Color(0xFFFF2156),
                  shape: BoxShape.circle,
                ),
                child: new IconButton(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context, "OK");
                  },
                  icon: new Icon(Icons.keyboard_arrow_right),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
