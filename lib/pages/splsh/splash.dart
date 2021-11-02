// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'dart:async';
import 'package:blood_donation/pages/bording/on_boarding.dart';
import 'package:blood_donation/pages/home/home.dart';
import 'package:blood_donation/pages/update_user_info/user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MySplash extends StatefulWidget {
  const MySplash({Key? key}) : super(key: key);

  @override
  State<MySplash> createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  void initState() {
    super.initState();

    new Timer(
      new Duration(seconds: 1),
      () {
        if (FirebaseAuth.instance.currentUser == null) {
          Navigator.pushAndRemoveUntil(
            context,
            new MaterialPageRoute(
              builder: (context) {
                return new OnBoarding();
              },
            ),
            (route) => false,
          );
        }
        FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((snapshot) => {
                  if (snapshot.exists)
                    {
                      if (snapshot.data()!.isNotEmpty)
                        {
                          Navigator.pushAndRemoveUntil(
                            context,
                            new MaterialPageRoute(
                              builder: (context) {
                                return new MyHome();
                              },
                            ),
                                (route) => false,
                          ),
                        }
                      else
                        {
                          Navigator.pushAndRemoveUntil(
                            context,
                            new MaterialPageRoute(
                              builder: (context) {
                                return new UpdateUserInfo();
                              },
                            ),
                                (route) => false,
                          ),
                        }
                    }
                  else
                    {
                      Navigator.pushAndRemoveUntil(
                        context,
                        new MaterialPageRoute(
                          builder: (context) {
                            return new UpdateUserInfo();
                          },
                        ),
                            (route) => false,
                      ),
                    }
                });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        //body container
        height: double.infinity,
        width: double.infinity,
        color: new Color(0xFFFF2156),
        child: new Stack(
          children: [
            new Positioned(
              //splash bg component
              bottom: 0,
              right: 0,
              left: 0,
              child: new SizedBox(
                width: double.infinity,
                child: new SvgPicture.asset(
                  "assets/icons/splash_foreground.svg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: new Column(
                //icon, label and progressbar
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new SvgPicture.asset(
                    "assets/icons/drop_extended.svg",
                    height: 100,
                    width: 100,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  new Text(
                    "Dare to Donate",
                    style: new TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                  new SizedBox(
                    height: 20,
                  ),
                  new CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
