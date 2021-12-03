// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:blood_donation/components/constant/colors.dart';
import 'package:blood_donation/components/constant/size.dart';
import 'package:blood_donation/components/constant/styles.dart';
import 'package:blood_donation/model/my_user.dart';
import 'package:blood_donation/pages/find_donors/components/donor_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum SearchBarState {
  expanded,
  collapsed,
}

class Donors extends StatefulWidget {
  const Donors({Key? key}) : super(key: key);

  @override
  State<Donors> createState() => _DonorsState();
}

class _DonorsState extends State<Donors> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _usersStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _usersStream = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
      child: new Scaffold(
        backgroundColor: MyColors.white,
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
              List<MyUser> users = <MyUser>[];
              for (var element in snapshot.data!.docs) {
                users.add(MyUser.fromJson(element.data()));
              }

              return NestedScrollView(
                body: new CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MySizes.defaultSpace / 2),
                      sliver: new SliverList(
                        delegate: new SliverChildBuilderDelegate(
                          (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: MySizes.defaultSpace / 2),
                              child: new DonorTile(
                                user: users[index],
                              ),
                            );
                          },
                          childCount: users.length,
                        ),
                      ),
                    ),
                  ],
                ),
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    new SliverAppBar(
                      centerTitle: true,
                      pinned: true,
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
                    // //my searchBar():
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: MySizes.defaultSpace / 2),
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      MySizes.defaultRadius),
                                ),
                                contentPadding:
                                    const EdgeInsets.all(MySizes.defaultSpace),
                                hintText: "Search donor",
                                fillColor: MyColors.primary.withOpacity(0.05),
                                filled: true,
                                prefixIcon: IconButton(
                                  onPressed: () {
                                    //TODO:
                                  },
                                  icon: const Icon(Icons.wc),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    //TODO:
                                    // if (text.isNotEmpty) {
                                    //   users.clear();
                                    //   for (var element in snapshot.data!.docs) {
                                    //     MyUser user =
                                    //     MyUser.fromJson(element.data());
                                    //     if (user.username!.contains(text)) {
                                    //       users.add(user);
                                    //     }
                                    //   }
                                    // }
                                  },
                                  icon: const Icon(
                                    Icons.search,
                                    color: MyColors.primary,
                                  ),
                                ),
                              ),
                            ),
                            // new Visibility(
                            //   visible: isVisibleFilters,
                            //   child: new Column(
                            //     children: [
                            //       new Container(
                            //         padding:
                            //             EdgeInsets.symmetric(vertical: 10),
                            //         decoration: new BoxDecoration(
                            //           color: Colors.white,
                            //           boxShadow: [
                            //             new BoxShadow(
                            //               color:
                            //                   Colors.grey.withOpacity(0.2),
                            //               blurRadius: 10,
                            //               spreadRadius: 10,
                            //             ),
                            //           ],
                            //         ),
                            //         alignment: Alignment.center,
                            //         width: double.infinity,
                            //         child: new Text(
                            //           "Filters",
                            //           style: new TextStyle(
                            //             fontSize: 20,
                            //             letterSpacing: 1.25,
                            //             fontWeight: FontWeight.bold,
                            //           ),
                            //         ),
                            //       ),
                            //       new SizedBox(
                            //         height: 10,
                            //       ),
                            //       Container(
                            //         width: double.infinity,
                            //         height: 300,
                            //         child: new SingleChildScrollView(
                            //           child: new Column(
                            //             children: [
                            //               new FilterOptions(
                            //                 itemList: [
                            //                   "A+",
                            //                   "B+",
                            //                   "O+",
                            //                   "AB+"
                            //                 ],
                            //                 title: "Blood Type",
                            //               ),
                            //               new FilterOptions(
                            //                 itemList: ["Dhaka", "Cumilla"],
                            //                 title: "Location",
                            //               ),
                            //               new FilterOptions(
                            //                 itemList: [
                            //                   "BLood bank name",
                            //                   "Blood bank name"
                            //                 ],
                            //                 title: "Blood Bank",
                            //               ),
                            //               new FilterOptions(
                            //                 itemList: ["Name", "Name"],
                            //                 title: "Donors",
                            //               ),
                            //               new SizedBox(
                            //                 height: 20,
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //       ),
                            //       new MyFilledButton(
                            //         child: new Text(
                            //           "Apply",
                            //           style: TextStyle(
                            //             color: Colors.white,
                            //             fontSize: 20,
                            //             letterSpacing: 1.2,
                            //             fontWeight: FontWeight.bold,
                            //           ),
                            //         ),
                            //         size: new Size(0, 0),
                            //         borderRadius: 50,
                            //         function: () {},
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ];
                },
              );
            }),
      ),
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchUsers() {
    return FirebaseFirestore.instance.collection("users").snapshots();
  }
}
