import 'package:blood_donation/components/constant/colors.dart';
import 'package:blood_donation/components/constant/size.dart';
import 'package:blood_donation/components/constant/styles.dart';
import 'package:blood_donation/pages/authentication/authentication.dart';
import 'package:blood_donation/pages/home/home.dart';
import 'package:blood_donation/pages/update_user_info/update_user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: SizedBox(
              width: double.infinity,
              child: SvgPicture.asset(
                "assets/icons/splash_foreground.svg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/drop_extended.svg",
                  height: MySizes.largeIconSize,
                  width: MySizes.largeIconSize,
                ),
                const SizedBox(
                  height: MySizes.defaultSpace,
                ),
                Text(
                  "Dare to Donate",
                  style: MyTextStyles(MyColors.white).largeTextStyle,
                ),
                const SizedBox(
                  height: MySizes.defaultSpace,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            left: 10,
            child: Builder(
              builder: (context) {
                Future.microtask(() =>
                    navigateToDesiredPage(FirebaseAuth.instance.currentUser));
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }

  void navigateToDesiredPage(User? currentUser) async {
    if (currentUser != null) {
      try {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .get();
        if (snapshot.data() != null && snapshot.data()!.isNotEmpty) {
          Get.offAll(() => const Home());
        } else {
          Get.offAll(() => const UpdateUserInfo());
        }
      } on FirebaseException catch (e) {
        Get.snackbar("Warning!", "${e.code}.\n Please restart your App");
      }
    } else {
      Get.offAll(() => const Authentication());
    }
  }
}
