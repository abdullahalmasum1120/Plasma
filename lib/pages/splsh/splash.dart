// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:blood_donation/components/filled_Button.dart';
import 'package:blood_donation/pages/bording/on_boarding.dart';
import 'package:blood_donation/pages/home/home.dart';
import 'package:blood_donation/pages/update_user_info/user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MySplash extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  MySplash({Key? key}) : super(key: key);

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
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              left: 10,
              child: (user != null)
                  ? new FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            new SnackBar(
                              content: new Text("Error checking details"),
                            ),
                          );
                        }
                        if (snapshot.hasData && !snapshot.data!.exists) {
                          Future.microtask(() => Navigator.pushAndRemoveUntil(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) {
                                    return new UpdateUserInfo();
                                  },
                                ),
                                (route) => false,
                              ));
                        }
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.data!.data() != null) {
                          Future.microtask(() => Navigator.pushAndRemoveUntil(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) {
                                    return new MyHome();
                                  },
                                ),
                                (route) => false,
                              ));
                        }

                        return new Center(
                          child: new CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      })
                  : new MyFilledButton(
                      child: new Text(
                        "Get Started",
                        style: new TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                        ),
                      ),
                      size: Size(double.infinity, 0),
                      function: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          new MaterialPageRoute(builder: (context) {
                            return OnBoarding();
                          }),
                          (route) => false,
                        );
                      },
                      borderRadius: 10,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
