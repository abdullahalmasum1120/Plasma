// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:blood_donation/pages/notifications/notification.dart';
import 'package:blood_donation/pages/profile/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final String uid;

  const MyAppBar({
    Key? key,
    required this.context,
    required this.uid,
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
        new StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(uid)
                .collection("receivedRequests")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return new Center(child: new Text("Error loading Data"));
              }
              if (!snapshot.hasData) {
                return new Center(child: new Text("Document does not exist"));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return new Center(
                  child: new CircularProgressIndicator(
                    color: new Color(0xFFFF2156),
                  ),
                );
              }
              List<QueryDocumentSnapshot<Map<String, dynamic>>> notifications =
                  snapshot.data!.docs;

              int unread = 0;

              for (var i in notifications) {
                if (i["status"] == "unread") {
                  unread++;
                }
              }

              return new IconButton(
                onPressed: () {
                  Get.to(() => new Notifications());
                },
                icon: new Badge(
                  badgeColor: new Color(0xFFFF2156),
                  badgeContent: new Text(
                    unread.toString(),
                    style: new TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  showBadge: (unread != 0),
                  child: new Icon(
                    Icons.notifications_outlined,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              );
            }),
        new SizedBox(
          width: 10,
        ),
        new GestureDetector(
          onTap: () {
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
          child: new CircleAvatar(
            radius: 16,
            backgroundColor: Colors.transparent,
            child: (FirebaseAuth.instance.currentUser!.photoURL == null)
                ? new Icon(
                    Icons.account_circle_outlined,
                    color: Colors.black,
                    size: 30,
                  )
                : null,
            backgroundImage:
                (FirebaseAuth.instance.currentUser!.photoURL != null)
                    ? new NetworkImage(
                        FirebaseAuth.instance.currentUser!.photoURL.toString())
                    : null,
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
