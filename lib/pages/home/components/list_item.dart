// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class MyListCard extends StatelessWidget {
  final BuildContext context;
  final int index;
  final QueryDocumentSnapshot<Map<String, dynamic>> requestData;

  const MyListCard({
    Key? key,
    required this.context,
    required this.index,
    required this.requestData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      shape: new RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: new Container(
        padding: EdgeInsets.all(10),
        color: Colors.white,
        child: new Row(
          children: [
            new Expanded(
              flex: 2,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Text(
                        "Location",
                        style: new TextStyle(
                          color: Colors.grey,
                          letterSpacing: 1.25,
                          fontSize: 16,
                        ),
                      ),
                      new Text(
                        requestData["location"],
                        style: new TextStyle(
                          color: Colors.black,
                          letterSpacing: 1.25,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  new SizedBox(
                    height: 10,
                  ),
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Text(
                        "Hospital",
                        style: new TextStyle(
                          color: Colors.grey,
                          letterSpacing: 1.25,
                          fontSize: 16,
                        ),
                      ),
                      new Text(
                        requestData["hospital"],
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          letterSpacing: 1.25,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  new SizedBox(
                    height: 20,
                  ),
                  new Text(
                    requestData["requestedTime"],
                    style: new TextStyle(
                      color: Colors.grey,
                      letterSpacing: 1.25,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            new Expanded(
              flex: 1,
              child: new Column(
                children: [
                  new Stack(
                    children: [
                      new Container(
                        decoration: new BoxDecoration(
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 20,
                              offset: new Offset(8, 5),
                            ),
                          ],
                        ),
                        child: new SvgPicture.asset(
                          "assets/icons/drop.svg",
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      new Positioned(
                        top: 25,
                        left: 10,
                        child: new Text(
                          requestData["bloodGroup"],
                          style: new TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  new SizedBox(
                    height: 20,
                  ),
                  new GestureDetector(
                    onTap: () {
                      launch("tel:${requestData["phone"]}");
                    },
                    child: new Text(
                      "Donate",
                      style: new TextStyle(
                        color: new Color(0xFFFF2156),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
