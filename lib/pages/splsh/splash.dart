// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:blood_donation/components/filled_Button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Container(
        height: double.infinity,
        width: double.infinity,
        color: new Color(0xFFFF2156),
        child: new Stack(
          children: [
            new Positioned(
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
            new Center(
              child: new Column(
                //icon, label and progressbar
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new SvgPicture.asset(
                    "assets/icons/drop_extended.svg",
                    height: 100,
                    width: 100,
                  ),
                  new SizedBox(
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
            new Positioned(
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
                        if (!(snapshot.hasData &&
                            snapshot.data!.exists &&
                            snapshot.data!.data() != null)) {
                          Future.microtask(
                              () => Get.offAllNamed("/userInfoUpdate"));
                        }
                        if (snapshot.connectionState == ConnectionState.done) {
                          Future.microtask(() => Get.offAllNamed("/home"));
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
                      size: new Size(double.infinity, 0),
                      function: () => Get.toNamed("/boarding"),
                      borderRadius: 10,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
