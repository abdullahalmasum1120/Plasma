// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:blood_donation/model/all_lists.dart';
import 'package:blood_donation/pages/home/components/grid_item.dart';
import 'package:blood_donation/pages/home/components/list_item.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MyBody extends StatefulWidget {
  final BuildContext context;

  const MyBody({
    Key? key,
    required this.context,
  }) : super(key: key);

  @override
  State<MyBody> createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final CarouselController _carouselController = CarouselController();

    return new CustomScrollView(
      slivers: [
        new SliverToBoxAdapter(
          child: new CarouselSlider.builder(
            carouselController: _carouselController,
            options: new CarouselOptions(
                viewportFraction: 1.0,
                autoPlay: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentImageIndex = index;
                  });
                }),
            itemCount: DataLists.getImageList().length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: new Container(
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: new Offset(5, 10),
                          blurRadius: 10,
                        ),
                      ]),
                  height: 250,
                  width: double.infinity,
                  child: new ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: new Image.network(
                      DataLists.getImageList()[index],
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
            children: DataLists.getImageList().asMap().entries.map(
              (entry) {
                return GestureDetector(
                  onTap: () {
                    _carouselController.animateToPage(entry.key);
                  },
                  child: Container(
                    width: 10,
                    height: 10,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentImageIndex == entry.key
                          ? new Color(0xFFFF2156)
                          : Colors.black.withOpacity(0.2),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
        new SliverPadding(
          padding: EdgeInsets.all(10),
          sliver: new SliverGrid(
            delegate: new SliverChildBuilderDelegate(
              (context, index) {
                return new MyGridCard(
                  context: context,
                  index: index,
                  src: DataLists.getGridItems()[index]["src"],
                  label: DataLists.getGridItems()[index]["label"],
                  widgetToNavigate: DataLists.getGridItems()[index]["onTap"],
                );
              },
              childCount: DataLists.getGridItems().length,
            ),
            gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
          ),
        ),
        new SliverAppBar(
          pinned: true,
          titleTextStyle: new TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
          automaticallyImplyLeading: false,
          title: new Text("Donation Request"),
          backgroundColor: Colors.white,
        ),
        new SliverPadding(
          padding: EdgeInsets.all(10),
          sliver: new SliverList(
            delegate: new SliverChildBuilderDelegate(
              (context, index) {
                return new MyListCard(
                  context: context,
                  index: index,
                  requestData: DataLists.getRequestList()[index],
                );
              },
              childCount: DataLists.getRequestList().length,
            ),
          ),
        ),
      ],
    );
  }
}
