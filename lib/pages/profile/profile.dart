// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'dart:io';
import 'package:blood_donation/components/dialogs/loading.dart';
import 'package:blood_donation/components/dialogs/request_succesful.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class Profile extends StatelessWidget {
  final String uid;

  const Profile({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        elevation: 0,
        centerTitle: true,
        leading: new IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: new Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: Colors.white,
        title: new Text(
          "Profile",
          style: new TextStyle(
            color: new Color(0xFFFF2156),
            fontSize: 24,
          ),
        ),
        actions: [
          new IconButton(
            color: new Color(0xFFFF2156),
            onPressed: () {},
            icon: new Icon(Icons.edit),
          ),
        ],
      ),
      body: new Container(
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
        child: new SingleChildScrollView(
          child: new Padding(
            padding: const EdgeInsets.all(10),
            child: new StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return new Center(child: new Text("Error loading Data"));
                  }
                  if (snapshot.hasData && !snapshot.data!.exists) {
                    return new Center(
                        child: new Text("Document does not exist"));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return new Center(
                      child: new CircularProgressIndicator(
                        color: new Color(0xFFFF2156),
                      ),
                    );
                  }

                  Map<String, dynamic> userData =
                      snapshot.data!.data() as Map<String, dynamic>;

                  return new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      new Container(
                        decoration: new BoxDecoration(
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              offset: new Offset(10, 10),
                              blurRadius: 40,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                        child: new Stack(
                          children: [
                            new ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: (userData["image"] != null)
                                  ? new Image.network(
                                      userData["image"],
                                      fit: BoxFit.cover,
                                      height: 150,
                                      width: 150,
                                    )
                                  : new Icon(
                                      Icons.account_box,
                                      size: 150,
                                      color: new Color(0xFFFF2156),
                                    ),
                            ),
                            (FirebaseAuth.instance.currentUser!.uid == uid)
                                ? new Positioned(
                                    bottom: 5,
                                    right: 5,
                                    child: new Container(
                                      decoration: new BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                          color: new Color(0xFFFF2156),
                                        ),
                                      ),
                                      child: new GestureDetector(
                                        onTap: () async {
                                          try {
                                            XFile? file = await ImagePicker()
                                                .pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            Reference reference = FirebaseStorage
                                                .instance
                                                .ref("profileImagesOfUser")
                                                .child(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                .child(
                                                    "profileImage.${path.extension(file!.path)}");

                                            await reference
                                                .putFile(File(file.path));

                                            String url = await reference
                                                .getDownloadURL();

                                            await FirebaseFirestore.instance
                                                .collection("users")
                                                .doc(uid)
                                                .update({"image": url});

                                            FirebaseAuth.instance.currentUser!
                                                .updatePhotoURL(url);
                                          } on FirebaseException catch (e) {
                                            Get.snackbar("Warning!", e.code);
                                          }
                                        },
                                        child: new Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: new Icon(
                                            Icons.camera_alt,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : new SizedBox(),
                          ],
                        ),
                      ),
                      new SizedBox(
                        height: 20,
                      ),
                      new Text(
                        userData["username"],
                        style: new TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.50,
                        ),
                      ),
                      new SizedBox(
                        height: 10,
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          new Icon(
                            Icons.location_on,
                            color: new Color(0xFFFF2156),
                          ),
                          new Text(
                            "Location",
                            style: new TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              letterSpacing: 1.25,
                            ),
                          ),
                        ],
                      ),
                      new Text(
                        userData["location"],
                        style: new TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          letterSpacing: 1.25,
                        ),
                      ),
                      new SizedBox(
                        height: 40,
                      ),
                      (FirebaseAuth.instance.currentUser!.uid != uid)
                          ? new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                new ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    primary: Colors.grey,
                                    shape: new RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  onPressed: () {
                                    launch("tel:${userData["phone"]}");
                                  },
                                  child: new Row(
                                    children: [
                                      new Icon(Icons.call_outlined),
                                      new SizedBox(
                                        width: 10,
                                      ),
                                      new Text(
                                        "Call Now",
                                        style: new TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          letterSpacing: 1.25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                new ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    primary: new Color(0xFFFF2156),
                                    shape: new RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  onPressed: () async {
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return new Loading();
                                        });
                                    String id = Uuid().v1();

                                    Map<String, dynamic> receivedRequest = {
                                      "time": DateFormat('kk:mm')
                                          .format(DateTime.now()),
                                      "date": DateFormat('yyyy-MM-dd')
                                          .format(DateTime.now()),
                                      "uid": FirebaseAuth
                                          .instance.currentUser!.uid,
                                      "status": "unread",
                                      "docId": id,
                                    };
                                    Map<String, dynamic> sentRequest = {
                                      "uid": uid,
                                      "status": "unread",
                                      "docId": id,
                                    };
                                    try {
                                      await FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(uid)
                                          .collection("recievedRequests")
                                          .doc(id)
                                          .set(receivedRequest);
                                      await FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .collection("sentRequests")
                                          .doc(id)
                                          .set(sentRequest);

                                      await FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .update({
                                        "requested": userData["requested"]++
                                      });

                                      Navigator.pop(context);
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return new SuccessfulDialog();
                                          });
                                    } on FirebaseException catch (e) {
                                      Navigator.pop(context);
                                      Get.snackbar("Warning!", e.code);
                                    }
                                  },
                                  child: new Row(
                                    children: [
                                      new Icon(Icons.screen_share_outlined),
                                      new SizedBox(
                                        width: 10,
                                      ),
                                      new Text(
                                        "Request",
                                        style: new TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          letterSpacing: 1.25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : new SizedBox(),
                      new SizedBox(
                        height: 20,
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          new Card(
                            elevation: 2,
                            child: new Padding(
                              padding: const EdgeInsets.all(10),
                              child: new Column(
                                children: [
                                  new Text(
                                    userData["bloodGroup"],
                                    style: new TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  new Text(
                                    "blood Type",
                                    style: new TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          new Card(
                            elevation: 2,
                            child: new Padding(
                              padding: const EdgeInsets.all(10),
                              child: new Column(
                                children: [
                                  new Text(
                                    userData["donated"].toString(),
                                    style: new TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  new Text(
                                    "Donated",
                                    style: new TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          new Card(
                            elevation: 2,
                            child: new Padding(
                              padding: const EdgeInsets.all(10),
                              child: new Column(
                                children: [
                                  new Text(
                                    userData["requested"].toString(),
                                    style: new TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  new Text(
                                    "Requested",
                                    style: new TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      new SizedBox(
                        height: 20,
                      ),
                      new Card(
                        elevation: 2,
                        child: new Container(
                          height: 50,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: new Row(
                            children: [
                              new Icon(
                                Icons.timelapse_outlined,
                                color: new Color(0xFFFF2156),
                              ),
                              new SizedBox(
                                width: 10,
                              ),
                              new Expanded(
                                child: new Text("Available for Donate"),
                              ),
                              new FlutterSwitch(
                                width: 60,
                                activeColor: new Color(0xFFFF2156),
                                value: userData["isAvailable"],
                                onToggle: (isOpen) async {
                                  if (FirebaseAuth.instance.currentUser!.uid ==
                                      uid) {
                                    try {
                                      await FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(uid)
                                          .update({"isAvailable": isOpen});
                                    } on FirebaseException catch (e) {
                                      Get.snackbar("Warning!", e.code);
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      new SizedBox(
                        height: 10,
                      ),
                      new Card(
                        elevation: 2,
                        child: new Container(
                          height: 50,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: new Row(
                            children: [
                              new Icon(
                                Icons.share_outlined,
                                color: new Color(0xFFFF2156),
                              ),
                              new SizedBox(
                                width: 10,
                              ),
                              new Expanded(
                                child: new Text("Invite a friend"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      new SizedBox(
                        height: 10,
                      ),
                      new Card(
                        elevation: 2,
                        child: new Container(
                          height: 50,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: new Row(
                            children: [
                              new Icon(
                                Icons.help_outline,
                                color: new Color(0xFFFF2156),
                              ),
                              new SizedBox(
                                width: 10,
                              ),
                              new Expanded(
                                child: new Text("Get help"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      new SizedBox(
                        height: 10,
                      ),
                      new Card(
                        elevation: 2,
                        child: new Container(
                          height: 50,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: new GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return new AlertDialog(
                                      shape: new RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      title: new Row(
                                        children: [
                                          new Icon(
                                            Icons.warning,
                                            color: Colors.amber,
                                          ),
                                          new SizedBox(
                                            width: 10,
                                          ),
                                          new Text("Warning!"),
                                        ],
                                      ),
                                      content:
                                          new Text("Do you want to Sign out?"),
                                      actions: [
                                        new GestureDetector(
                                          onTap: () {
                                            FirebaseAuth.instance.signOut();
                                            Get.offAllNamed("/authentication");
                                          },
                                          child: new Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 10,
                                            ),
                                            child: new Text(
                                              "Sign out",
                                              style: new TextStyle(
                                                color: new Color(0xFFFF2156),
                                              ),
                                            ),
                                          ),
                                        ),
                                        new GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: new Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 10,
                                            ),
                                            child: new Text(
                                              "Cancel",
                                              style: new TextStyle(
                                                color: new Color(0xFFFF2156),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: new Row(
                              children: [
                                new Icon(
                                  Icons.exit_to_app_outlined,
                                  color: new Color(0xFFFF2156),
                                ),
                                new SizedBox(
                                  width: 10,
                                ),
                                new Expanded(
                                  child: new Text("Sign out"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
