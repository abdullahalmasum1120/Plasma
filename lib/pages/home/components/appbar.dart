// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:blood_donation/pages/profile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;

  const MyAppBar({
    Key? key,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new AppBar(
      backgroundColor: Colors.white,
      title: new Text(
        "App Title",
        style: new TextStyle(
          color: new Color(0xFFFF2156),
        ),
      ),
      elevation: 0,
      actions: [
        new IconButton(
          onPressed: () {},
          icon: new Icon(
            Icons.notifications_outlined,
            color: Colors.black,
            size: 30,
          ),
        ),
        new IconButton(
          onPressed: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) {
                  return new Profile(
                    uid: FirebaseAuth.instance.currentUser!.uid,
                  );
                },
              ),
            );
          },
          icon: new Icon(
            Icons.account_circle_outlined,
            color: Colors.black,
            size: 30,
          ),
        ),
        new SizedBox(
          width: 10,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}
