// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:blood_donation/pages/find_donors/components/donor_tile.dart';
import 'package:flutter/material.dart';

class DonorList extends StatefulWidget {
  const DonorList({Key? key}) : super(key: key);

  @override
  _DonorListState createState() => _DonorListState();
}

class _DonorListState extends State<DonorList> {
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
  @override
  Widget build(BuildContext context) {
    return new SafeArea(
        child: new Scaffold(
      backgroundColor: Colors.white,
      body: new CustomScrollView(
        slivers: [
          new SliverAppBar(
            centerTitle: true,
            pinned: true,
            backgroundColor: Colors.white,
            leading: new IconButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: new Icon(Icons.arrow_back_ios),
            ),
            title: new Text(
              "Find Donor",
              style: new TextStyle(
                color: new Color(0xFFFF2156),
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.50,
              ),
            ),
          ),
          new SliverList(
            delegate: new SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: DonorTile(
                    donorInfo: donorList[index],
                  ),
                );
              },
              childCount: donorList.length,
            ),
          ),
        ],
      ),
    ));
  }
}
