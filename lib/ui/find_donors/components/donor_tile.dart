// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:blood_donation/components/constant/colors.dart';
import 'package:blood_donation/components/constant/size.dart';
import 'package:blood_donation/data/model/my_user.dart';
import 'package:blood_donation/ui/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DonorTile extends StatelessWidget {
  final MyUser user;
  const DonorTile({
    Key? key,
    required this.user,
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
                uid: user.uid!,
              );
            },
          ),
        );
      },
      child: new Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MySizes.defaultRadius),
        ),
        margin: EdgeInsets.zero,
        elevation: 2,
        child: new Container(
          padding: EdgeInsets.all(MySizes.defaultSpace/2),
          height: 100,
          width: double.infinity,
          child: new Row(
            children: [
              new ClipRRect(
                borderRadius: BorderRadius.circular(MySizes.defaultRadius),
                child: (user.image != null)
                    ? new Image.network(
                        user.image!,
                        fit: BoxFit.cover,
                        height: 80,
                        width: 80,
                      )
                    : new Icon(
                        Icons.account_box,
                        size: 80,
                        color: MyColors.primary,
                      ),
              ),
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: MySizes.defaultSpace/2,
                  ),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Text(
                        user.username!,
                        style: new TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      new SizedBox(
                        height: MySizes.defaultSpace/2,
                      ),
                      new Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          new Icon(
                            Icons.location_on_outlined,
                            color: MyColors.primary,
                          ),
                          new Expanded(
                            child: new Text(
                              user.location!,
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
                      left: 8,
                      top: 26,
                      child: new Text(
                        user.bloodGroup!,
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
