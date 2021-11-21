// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:blood_donation/pages/authentication/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class Profile extends StatelessWidget {
  final Map userData;

  const Profile({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: new Scaffold(
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
        body: Container(
          color: Colors.white,
          height: double.infinity,
          width: double.infinity,
          child: new SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
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
                    child: new ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: new Image.network(
                        userData["image"],
                        fit: BoxFit.cover,
                        height: 150,
                        width: 150,
                      ),
                    ),
                  ),
                  new SizedBox(
                    height: 20,
                  ),
                  new Text(
                    userData["name"],
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
                        userData["location"],
                        style: new TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          letterSpacing: 1.25,
                        ),
                      ),
                    ],
                  ),
                  new SizedBox(
                    height: 40,
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          primary: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: () {},
                        child: Row(
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
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          primary: new Color(0xFFFF2156),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: () {},
                        child: Row(
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
                  ),
                  new SizedBox(
                    height: 50,
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      new Card(
                        elevation: 5,
                        child: Padding(
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
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: new Column(
                            children: [
                              new Text(
                                userData["donated"],
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
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: new Column(
                            children: [
                              new Text(
                                userData["requested"],
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
                    elevation: 5,
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
                            onToggle: (isOpen) {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  new SizedBox(
                    height: 10,
                  ),
                  new Card(
                    elevation: 5,
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
                    elevation: 5,
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
                    elevation: 5,
                    child: new Container(
                      height: 50,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: new GestureDetector(
                        onTap: () {
                          FirebaseAuth.instance.signOut();

                          Navigator.pushAndRemoveUntil(
                            context,
                            new MaterialPageRoute(builder: (context) {
                              return new Authentication();
                            }),
                            (route) => false,
                          );
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
