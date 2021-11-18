// ignore_for_file: prefer_const_constructors, unnecessary_new, sized_box_for_whitespace, prefer_const_declarations

import 'package:blood_donation/components/filled_Button.dart';
import 'package:blood_donation/components/outlined_button.dart';
import 'package:blood_donation/pages/bording/components/first_page.dart';
import 'package:blood_donation/pages/bording/components/last_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Boarding extends StatefulWidget {
  const Boarding({
    Key? key,
  }) : super(key: key);

  @override
  State<Boarding> createState() => _BoardingState();
}

class _BoardingState extends State<Boarding> {
  @override
  Widget build(BuildContext context) {
    final PageController pageController = new PageController(
      initialPage: 0,
    );

    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: new Stack(
          //full page with stack
          children: [
            new PageView(
              controller: pageController,
              children: [
                new FirstPageView(),
                new LastPageView(),
              ],
            ),
            new Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: new Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    new MyOutlinedButton(
                      text: "Skip",
                      size: new Size(0, 0),
                      borderRadius: 10,
                      function: () => Get.toNamed("/authentication"),
                    ),
                    new MyFilledButton(
                      child: new Text(
                        "Next",
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      size: new Size(0, 0),
                      borderRadius: 10,
                      function: () {
                        setState(() {
                          if (pageController.page == 1) {
                            Get.toNamed("/authentication");
                          } else {
                            pageController.nextPage(
                              duration: new Duration(milliseconds: 500),
                              curve: Curves.easeOut,
                            );
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
