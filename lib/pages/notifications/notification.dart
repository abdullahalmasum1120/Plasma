// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:blood_donation/pages/profile/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Notifications extends StatelessWidget {
  const Notifications({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: new IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: new Icon(
              Icons.arrow_back_ios,
            )),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        title: new Text(
          "Notifications",
          style: new TextStyle(
            color: new Color(0xFFFF2156),
            fontSize: 24,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("recievedRequests")
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

            if (snapshot.data!.docs.isEmpty) {
              return new Center(
                child: new Text("No Notifications"),
              );
            }
            List<QueryDocumentSnapshot<Map<String, dynamic>>> notifications =
                snapshot.data!.docs;
            return new ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  return new GestureDetector(
                    onTap: () async {
                      try {
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("recievedRequests")
                            .doc(notifications[index]["docId"])
                            .update({"status": "read"});

                        Navigator.push(context,
                            new MaterialPageRoute(builder: (context) {
                          return new Profile(uid: notifications[index]["uid"]);
                        }));
                      } on FirebaseException catch (e) {
                        Get.snackbar("Warning!", e.code);
                      }
                    },
                    child: new ListTile(
                      leading: new Container(
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          border: (notifications[index]["status"] == "unread")
                              ? Border.all(
                                  color: new Color(0xFFFF2156),
                                  width: 3,
                                )
                              : null,
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/donate.svg",
                        ),
                      ),
                      title: new Text("Someone Requested you to Donate Blood"),
                      subtitle: new Text(
                          "${notifications[index]["time"]} ${notifications[index]["date"]}"),
                    ),
                  );
                });
          }),
    );
  }
}
