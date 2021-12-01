// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:blood_donation/pages/home/components/blood_request_dialog.dart';
import 'package:blood_donation/pages/home/components/appbar.dart';
import 'package:blood_donation/pages/home/components/body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new MyAppBar(
        context: context,
        uid: FirebaseAuth.instance.currentUser!.uid,
      ),
      body: new MyBody(context: context),
      floatingActionButton: new FloatingActionButton(
        tooltip: "Request for Blood",
        backgroundColor: new Color(0xFFFF2156),
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return new BloodRequestDialog();
            },
          );
        },
        child: new SvgPicture.asset(
          "assets/icons/drop_extended.svg",
        ),
      ),
    );
  }
}
