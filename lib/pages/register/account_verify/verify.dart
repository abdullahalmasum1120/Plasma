// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:blood_donation/components/filled_Button.dart';
import 'package:blood_donation/pages/register/finish_setup/finish.dart';
import 'package:flutter/material.dart';

class Verify extends StatelessWidget {
  const Verify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
        child: new Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new TextFormField(
                  showCursor: false,
                  style: new TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: new Color(0xFFFF2156),
                  ),
                  decoration: new InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    constraints: new BoxConstraints(
                      maxHeight: 80,
                      maxWidth: 60,
                    ),
                    border: InputBorder.none,
                    fillColor: new Color(0xFFF8F8F8),
                    filled: true,
                    focusedBorder: new OutlineInputBorder(
                      borderSide: new BorderSide(
                        width: 1,
                        color: new Color(0xFFFF2156),
                      ),
                    ),
                  ),
                  maxLength: 1,
                  keyboardType: TextInputType.number,
                ),
                new SizedBox(
                  width: 10,
                ),
                new TextFormField(
                  showCursor: false,
                  style: new TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: new Color(0xFFFF2156),
                  ),

                  decoration: new InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    constraints: new BoxConstraints(
                      maxHeight: 80,
                      maxWidth: 60,
                    ),
                    border: InputBorder.none,
                    fillColor: new Color(0xFFF8F8F8),
                    filled: true,
                    focusedBorder: new OutlineInputBorder(
                      borderSide: new BorderSide(
                        width: 1,
                        color: new Color(0xFFFF2156),
                      ),
                    ),
                  ),
                  maxLength: 1,
                  keyboardType: TextInputType.number,
                ),
                new SizedBox(
                  width: 10,
                ),
                new TextFormField(
                  showCursor: false,
                  style: new TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: new Color(0xFFFF2156),
                  ),
                  decoration: new InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    constraints: new BoxConstraints(
                      maxHeight: 80,
                      maxWidth: 60,
                    ),
                    border: InputBorder.none,
                    fillColor: new Color(0xFFF8F8F8),
                    filled: true,
                    focusedBorder: new OutlineInputBorder(
                      borderSide: new BorderSide(
                        width: 1,
                        color: new Color(0xFFFF2156),
                      ),
                    ),
                  ),
                  maxLength: 1,
                  keyboardType: TextInputType.number,
                ),
                new SizedBox(
                  width: 10,
                ),
                new TextFormField(
                  showCursor: false,
                  style: new TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: new Color(0xFFFF2156),
                  ),
                  decoration: new InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    constraints: new BoxConstraints(
                      maxHeight: 80,
                      maxWidth: 60,
                    ),
                    border: InputBorder.none,
                    fillColor: new Color(0xFFF8F8F8),
                    filled: true,
                    focusedBorder: new OutlineInputBorder(
                      borderSide: new BorderSide(
                        width: 1,
                        color: new Color(0xFFFF2156),
                      ),
                    ),
                  ),
                  maxLength: 1,
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
            new SizedBox(
              height: 20,
            ),
            new GestureDetector(
              onTap: (){

              },
              child: Container(
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: new Text(
                  "Resend code",
                  style: new TextStyle(
                    color: new Color(0xFFFF2156),
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            new SizedBox(
              height: 40,
            ),
            new MyFilledButton(
              child: new Text("VERIFY",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                ),),
              size: new Size(double.infinity, 0),
              borderRadius: 100,
              function: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) {
                      return new Finished();
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    ));
  }
}
