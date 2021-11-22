// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:blood_donation/pages/profile/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DonorTile extends StatelessWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> donorInfo;
  const DonorTile({
    Key? key,
    required this.donorInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (context) {
              return new Profile(
                uid: donorInfo["uid"],
              );
            },
          ),
        );
      },
      child: new Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(0),
        elevation: 2,
        child: new Container(
          padding: EdgeInsets.all(10),
          height: 100,
          width: double.infinity,
          child: new Row(
            children: [
              new ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: (donorInfo["image"] != null)
                    ? new Image.network(
                        donorInfo["image"],
                        fit: BoxFit.cover,
                        height: 80,
                        width: 80,
                      )
                    : new Icon(
                        Icons.account_box,
                        size: 80,
                        color: new Color(0xFFFF2156),
                      ),
              ),
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Text(
                        donorInfo["username"],
                        style: new TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      new SizedBox(
                        height: 10,
                      ),
                      new Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          new Icon(
                            Icons.location_on_outlined,
                            color: new Color(0xFFFF2156),
                          ),
                          new Expanded(
                            child: new Text(
                              donorInfo["location"],
                              style: new TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 60,
                width: 60,
                child: new Stack(
                  children: [
                    Container(
                      decoration: new BoxDecoration(
                        boxShadow: [
                          new BoxShadow(
                            offset: new Offset(5, 10),
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 50,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: new SvgPicture.asset(
                        "assets/icons/drop.svg",
                        height: 60,
                        width: 60,
                      ),
                    ),
                    new Positioned(
                      left: 10,
                      top: 25,
                      child: new Text(
                        donorInfo["bloodGroup"],
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
