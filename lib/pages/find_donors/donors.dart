// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:blood_donation/components/constant/colors.dart';
import 'package:blood_donation/components/constant/size.dart';
import 'package:blood_donation/components/constant/styles.dart';
import 'package:blood_donation/model/my_user.dart';
import 'package:blood_donation/pages/find_donors/components/donor_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'components/search.dart';

class Donors extends StatefulWidget {
  const Donors({Key? key}) : super(key: key);

  @override
  State<Donors> createState() => _DonorsState();
}

class _DonorsState extends State<Donors> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _usersStream;
  final TextEditingController searchController = TextEditingController();
  late ScrollController scrollController;
  ScrollDirection previousScrollDirection = ScrollDirection.reverse;
  List<MyUser> users = <MyUser>[];
  String searchKey = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _usersStream = _getUsersStream();
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.userScrollDirection !=
            previousScrollDirection) {
          setState(() {
            previousScrollDirection =
                scrollController.position.userScrollDirection;
          });
        }
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    scrollController.dispose();
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
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  (previousScrollDirection == ScrollDirection.forward)
                      ? previousScrollDirection = ScrollDirection.reverse
                      : previousScrollDirection = ScrollDirection.forward;
                });
              },
              icon: Icon(Icons.search),
            )
          ],
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
              return new Column(
                children: [
                  (previousScrollDirection == ScrollDirection.forward)
                      ? Padding(
                          padding:
                              const EdgeInsets.all(MySizes.defaultSpace / 2),
                          child: SearchBar(
                            suffixIcon: (searchKey.isEmpty)
                                ? Icons.search
                                : Icons.clear,
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
                        )
                      : SizedBox(),
                  Expanded(
                    child: new ListView.builder(
                      itemBuilder: ((context, index) {
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
                      itemCount: users.length,
                      shrinkWrap: true,
                      controller: scrollController,
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
        if (myUser.username!.contains(searchKey)) {
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
