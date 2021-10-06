// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:blood_donation/pages/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;

  const MyAppBar({
    Key? key,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map> donorList = [
      {
        "isAvailable": true,
        "donated": "05",
        "requested": "02",
        "name": "Sajibul islam",
        "location": "dhaka, mohammadpur",
        "bloodGroup": "A+",
        "image":
            "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260",
      },
      {
        "isAvailable": false,
        "donated": "05",
        "requested": "02",
        "name": "Ariful Islam",
        "location": "dhaka, Gazipur",
        "bloodGroup": "A-",
        "image":
            "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
      },
      {
        "isAvailable": true,
        "donated": "05",
        "requested": "02",
        "name": "Mariom akter",
        "location": "dhaka, Dhanmondi",
        "bloodGroup": "B-",
        "image":
            "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260",
      },
      {
        "isAvailable": false,
        "donated": "05",
        "requested": "02",
        "name": "Rubel",
        "location": "dhaka, Mirpur",
        "bloodGroup": "O+",
        "image":
            "https://images.pexels.com/photos/1040881/pexels-photo-1040881.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
      },
    ];
    return new AppBar(
      backgroundColor: Colors.white,
      leading: new IconButton(
        icon: new SvgPicture.asset(
          "assets/icons/drawer.svg",
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      title: new Text("title"),
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {},
          icon: new SvgPicture.asset(
            "assets/icons/notification.svg",
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) {
                  return new Profile(
                    userData: donorList[0],
                  );
                },
              ),
            );
          },
          icon: new SvgPicture.asset(
            "assets/icons/avatar.svg",
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}
