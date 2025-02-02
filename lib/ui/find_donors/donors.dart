// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:blood_donation/components/constant/colors.dart';
import 'package:blood_donation/components/constant/size.dart';
import 'package:blood_donation/components/constant/styles.dart';
import 'package:blood_donation/data/model/my_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'components/donor_tile.dart';
import 'components/search.dart';

class Donors extends StatefulWidget {
  const Donors({Key? key}) : super(key: key);

  @override
  State<Donors> createState() => _DonorsState();
}

class _DonorsState extends State<Donors> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _usersStream;
  final TextEditingController searchController = TextEditingController();
  List<MyUser> users = <MyUser>[];
  String searchKey = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _usersStream = _getUsersStream();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
      child: new Scaffold(
        backgroundColor: MyColors.white,
        appBar: new AppBar(
          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(color: MyColors.primary),
          backgroundColor: MyColors.white,
          leading: new IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: new Icon(Icons.arrow_back_ios),
          ),
          title: new Text(
            "Find Donor",
            style: MyTextStyles(MyColors.primary).titleTextStyle,
          ),
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: _usersStream,
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
                    color: MyColors.primary,
                  ),
                );
              }
              //populating users list
              users = fetchUsers(snapshot.data!.docs, searchKey);
              return new CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: MyColors.white,
                    toolbarHeight: 0,
                    elevation: 0,
                    floating: true,
                    bottom: SearchBar(
                      suffixIcon:
                          (searchKey.isEmpty) ? Icons.search : Icons.clear,
                      onClear: () {
                        setState(() {
                          searchKey = "";
                          searchController.text = searchKey;
                        });
                      },
                      controller: searchController,
                      context: context,
                      onChanged: (text) {
                        setState(() {
                          searchKey = text;
                        });
                      },
                    ),
                  ),
                  new SliverList(
                    delegate: SliverChildBuilderDelegate(
                      ((context, index) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(
                            MySizes.defaultSpace / 2,
                            MySizes.defaultSpace / 2,
                            MySizes.defaultSpace / 2,
                            0,
                          ),
                          child: new DonorTile(
                            user: users[index],
                          ),
                        );
                      }),
                      childCount: users.length,
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> _getUsersStream() {
    return FirebaseFirestore.instance.collection("users").snapshots();
  }

  List<MyUser> fetchUsers(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
      String searchKey) {
    List<MyUser> tempDocs = <MyUser>[];

    for (var element in docs) {
      MyUser myUser = MyUser.fromJson(element.data());
      if (searchKey.isNotEmpty) {
        if (myUser.username!.toLowerCase().contains(searchKey.toLowerCase()) ||
            myUser.location!.toLowerCase().contains(searchKey.toLowerCase()) ||
            myUser.bloodGroup!
                .toLowerCase()
                .contains(searchKey.toLowerCase())) {
          tempDocs.add(myUser);
        }
      }
      if (searchKey.isEmpty) {
        tempDocs.add(myUser);
      }
    }

    return tempDocs;
  }
}
