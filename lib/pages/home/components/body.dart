// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:blood_donation/components/constant/colors.dart';
import 'package:blood_donation/components/constant/size.dart';
import 'package:blood_donation/components/constant/styles.dart';
import 'package:blood_donation/data/model/featured_image.dart';
import 'package:blood_donation/data/model/grid_item.dart';
import 'package:blood_donation/pages/assistant/asistant.dart';
import 'package:blood_donation/pages/find_donors/donors.dart';
import 'package:blood_donation/pages/home/components/grid_item.dart';
import 'package:blood_donation/pages/home/components/list_item.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'blood_request_dialog.dart';

class MyBody extends StatefulWidget {
  final BuildContext context;
  final List<FeaturedImage> images;

  const MyBody({
    Key? key,
    required this.context,
    required this.images,
  }) : super(key: key);

  @override
  State<MyBody> createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> {
  //grids data list
  final List<GridData> grids = [
    GridData(
      icon: Icon(
        Icons.add,
        color: MyColors.primary,
      ),
      label: "Request",
      widget: BloodRequestDialog(),
      badgeText: '',
      widgetType: WidgetType.dialog,
    ),
    GridData(
      label: 'Find',
      icon: Icon(
        Icons.search,
        color: MyColors.primary,
      ),
      widget: Donors(),
      badgeText: '',
    ),
    GridData(
      icon: Icon(
        Icons.assistant,
        color: MyColors.primary,
      ),
      label: 'Assistant',
      widget: Assistant(),
      badgeText: '',
    ),
    // GridData(
    //   icon: Icon(
    //     Icons.campaign,
    //     color: MyColors.primary,
    //   ),
    //   label: 'Campaign',
    //   widget: Text("Not found"),
    //   badgeText: '',
    // ),
  ];
  int _currentImageIndex = 0;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _requestsStream;
  final CarouselController _carouselController = CarouselController();
  final ScrollController _customScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _requestsStream = fetchRequests();
  }

  @override
  void dispose() {
    _customScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _requestsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return new Center(
              child: new Text("Error loading Data"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return new Center(
              child: new CircularProgressIndicator(
                color: MyColors.primary,
              ),
            );
          }

          List<QueryDocumentSnapshot<Map<String, dynamic>>> requests =
              snapshot.data!.docs;
          return new CustomScrollView(
            controller: _customScrollController,
            slivers: [
              new SliverToBoxAdapter(
                child: new CarouselSlider.builder(
                  carouselController: _carouselController,
                  options: new CarouselOptions(
                      autoPlayInterval: Duration(seconds: 8),
                      viewportFraction: 1.0,
                      autoPlay: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentImageIndex = index;
                        });
                      }),
                  itemCount: widget.images.length,
                  itemBuilder:
                      (BuildContext context, int index, int realIndex) {
                    return Padding(
                      padding: const EdgeInsets.all(MySizes.defaultSpace),
                      child: new Container(
                        decoration: new BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(MySizes.defaultRadius),
                            boxShadow: [
                              new BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                offset: new Offset(4, 8),
                                blurRadius: 8,
                              ),
                            ]),
                        height: 240,
                        width: double.infinity,
                        child: new ClipRRect(
                          borderRadius:
                              BorderRadius.circular(MySizes.defaultRadius),
                          child: new Image.network(
                            widget.images[index].image.toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              new SliverToBoxAdapter(
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.images.asMap().entries.map(
                    (entry) {
                      return GestureDetector(
                        onTap: () {
                          _carouselController.animateToPage(entry.key);
                        },
                        child: Container(
                          width: 8,
                          height: 8,
                          margin: EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentImageIndex == entry.key
                                ? MyColors.primary
                                : Colors.black.withOpacity(0.2),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
              new SliverPadding(
                padding: EdgeInsets.all(MySizes.defaultSpace / 2),
                sliver: new SliverGrid(
                  delegate: new SliverChildBuilderDelegate(
                    (context, index) {
                      return new MyGridCard(
                        context: context,
                        icon: grids[index].icon,
                        label: grids[index].label,
                        widgetToNavigate: grids[index].widget,
                        badgeText: grids[index].badgeText,
                        widgetType: grids[index].widgetType,
                      );
                    },
                    childCount: grids.length,
                  ),
                  gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 140,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                ),
              ),
              new SliverAppBar(
                pinned: true,
                floating: true,
                titleTextStyle: MyTextStyles(MyColors.black).titleTextStyle,
                automaticallyImplyLeading: false,
                title: GestureDetector(
                  onTap: () {
                    _customScrollController.animateTo(
                      0,
                      duration: Duration(seconds: 1),
                      curve: Curves.fastOutSlowIn,
                    );
                  },
                  child: new Text("Donation Requests"),
                ),
                backgroundColor: Colors.white,
              ),
              new SliverPadding(
                padding: EdgeInsets.all(8),
                sliver: (requests.isEmpty)
                    ? new SliverToBoxAdapter(
                        child: new Center(
                          child: new Text("No new request found"),
                        ),
                      )
                    : new SliverList(
                        delegate: new SliverChildBuilderDelegate(
                          (context, index) {
                            return new MyListCard(
                              context: context,
                              index: index,
                              requestData: requests[index],
                            );
                          },
                          childCount: requests.length,
                        ),
                      ),
              ),
            ],
          );
        });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchRequests() {
    return FirebaseFirestore.instance.collection("requests").snapshots();
  }
}
