// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:blood_donation/components/dialogs/blood_request_dialog.dart';
import 'package:blood_donation/pages/home/components/appbar.dart';
import 'package:blood_donation/pages/home/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyHome extends StatefulWidget {
  const MyHome({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      drawer: new Drawer(),
      appBar: new MyAppBar(context: context),
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
