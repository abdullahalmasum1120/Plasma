// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:blood_donation/components/constant/colors.dart';
import 'package:blood_donation/components/constant/styles.dart';
import 'package:blood_donation/model/received_request.dart';
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
      backgroundColor: MyColors.white,
      appBar: new AppBar(
        iconTheme: const IconThemeData(
          color: MyColors.primary,
        ),
        leading: new IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: new Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.white,
        elevation: 0,
        title: new Text(
          "Notifications",
          style: MyTextStyles(MyColors.primary).titleTextStyle,
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
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
                  color: MyColors.primary,
                ),
              );
            }

            if (snapshot.data!.docs.isEmpty) {
              return new Center(
                child: new Text("No Notifications"),
              );
            }
            //populate List of notifications
            List<ReceivedRequest> receivedRequests = <ReceivedRequest>[];
            for (var element in snapshot.data!.docs) {
              receivedRequests.add(ReceivedRequest.fromJson(element.data()));
            }
            return new ListView.builder(
                itemCount: receivedRequests.length,
                itemBuilder: (context, index) {
                  return new GestureDetector(
                    onTap: () async {
                      try {
                        //mark as read
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("receivedRequests")
                            .doc(receivedRequests[index].docId)
                            .update({"status": "read"});

                        Navigator.push(context,
                            new MaterialPageRoute(builder: (context) {
                          return new Profile(uid: receivedRequests[index].uid!);
                        }));
                      } on FirebaseException catch (e) {
                        Get.snackbar("Warning!", e.code);
                      }
                    },
                    child: new ListTile(
                      leading: new Container(
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          border: (receivedRequests[index].status == "unread")
                              ? Border.all(
                                  color: MyColors.primary,
                                  width: 3,
                                )
                              : null,
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/donate.svg",
                        ),
                      ),
                      title: new Text(
                        "Someone Requested you to Donate Blood",
                        style: MyTextStyles(MyColors.black).defaultTextStyle,
                      ),
                      subtitle: new Text(
                          "${receivedRequests[index].time} : ${receivedRequests[index].date}"),
                    ),
                  );
                });
          }),
    );
  }
}
