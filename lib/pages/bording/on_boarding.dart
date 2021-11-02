// ignore_for_file: prefer_const_constructors, unnecessary_new, sized_box_for_whitespace, prefer_const_declarations

import 'package:blood_donation/components/filled_Button.dart';
import 'package:blood_donation/components/outlined_button.dart';
import 'package:blood_donation/pages/authentication/phone_auth.dart';
import 'package:blood_donation/pages/bording/components/first_page.dart';
import 'package:blood_donation/pages/bording/components/last_page.dart';
import 'package:blood_donation/pages/bording/final_boarding.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({
    Key? key,
  }) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    final PageController pageController = new PageController(
      initialPage: 0,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        //body container
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
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    new MyOutlinedButton(
                      text: "Skip",
                      size: new Size(0, 0),
                      borderRadius: 10,
                      function: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          new MaterialPageRoute(
                            builder: (context) {
                              return new PhoneAuth();
                            },
                          ),
                          (route) => false,
                        );
                      },
                    ),
                    new MyFilledButton(
                      child: new Text(
                        "Next",
                        style: TextStyle(
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
                            Navigator.pushAndRemoveUntil(
                              context,
                              new MaterialPageRoute(
                                builder: (context) {
                                  return new PhoneAuth();
                                },
                              ),
                              (route) => false,
                            );
                          } else {
                            pageController.nextPage(
                              duration: new Duration(seconds: 1),
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
