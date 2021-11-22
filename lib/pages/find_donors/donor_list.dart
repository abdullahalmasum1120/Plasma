// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:blood_donation/pages/find_donors/components/donor_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DonorList extends StatelessWidget {
  const DonorList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection("users").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return new Center(child: new Text("Error loading Data"));
            }
            if (!snapshot.hasData) {
              return new Center(child: new Text("Data does not exist"));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return new Center(
                child: new CircularProgressIndicator(
                  color: new Color(0xFFFF2156),
                ),
              );
            }
            List<QueryDocumentSnapshot<Map<String, dynamic>>> users =
                snapshot.data!.docs;

            return new CustomScrollView(
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
                      return new Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: new DonorTile(
                          donorInfo: users[index],
                        ),
                      );
                    },
                    childCount: users.length,
                  ),
                ),
              ],
            );
          }),
    );
  }
}
