import 'package:blood_donation/components/constant/colors.dart';
import 'package:blood_donation/components/constant/size.dart';
import 'package:blood_donation/components/constant/styles.dart';
import 'package:blood_donation/ui/notifications/notification.dart';
import 'package:blood_donation/ui/profile/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final String uid;

  const MyAppBar({
    Key? key,
    required this.context,
    required this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: MyColors.black),
      backgroundColor: MyColors.white,
      title: Text(
        "App Title",
        style: MyTextStyles(MyColors.primary).titleTextStyle,
      ),
      elevation: 0,
      actions: [
        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(uid)
                .collection("receivedRequests")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text("Error loading Data"));
              }
              if (!snapshot.hasData) {
                return const Center(child: Text("Document does not exist"));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: MyColors.primary,
                  ),
                );
              }
              List<QueryDocumentSnapshot<Map<String, dynamic>>> notifications =
                  snapshot.data!.docs;

              int unread = 0;

              for (var i in notifications) {
                if (i["status"] == "unread") {
                  unread++;
                }
              }

              return IconButton(
                onPressed: () {
                  Get.to(() => Notifications());
                },
                icon: Badge(
                  badgeColor: MyColors.primary,
                  badgeContent: Text(
                    unread.toString(),
                    style: MyTextStyles(MyColors.white).badgeTextStyle,
                  ),
                  showBadge: (unread != 0),
                  child: const Icon(
                    Icons.notifications_outlined,
                    size: 30,
                  ),
                ),
              );
            }),
        const SizedBox(
          width: MySizes.defaultSpace / 2,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Profile(
                    uid: FirebaseAuth.instance.currentUser!.uid,
                  );
                },
              ),
            );
          },
          child: CircleAvatar(
            radius: MySizes.defaultRadius * 2,
            backgroundColor: Colors.transparent,
            child: (FirebaseAuth.instance.currentUser!.photoURL == null)
                ? const Icon(
                    Icons.account_circle_outlined,
                    size: 30,
                    color: MyColors.black,
                  )
                : null,
            backgroundImage:
                (FirebaseAuth.instance.currentUser!.photoURL != null)
                    ? NetworkImage(
                        FirebaseAuth.instance.currentUser!.photoURL.toString())
                    : null,
          ),
        ),
        const SizedBox(
          width: MySizes.defaultSpace,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
