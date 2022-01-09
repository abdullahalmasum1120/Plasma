import 'package:blood_donation/components/constant/colors.dart';
import 'package:blood_donation/components/constant/size.dart';
import 'package:blood_donation/components/constant/styles.dart';
import 'package:blood_donation/data/model/notification.dart';
import 'package:blood_donation/ui/home/logic/blocs/notifications_bloc/notifications_bloc.dart';
import 'package:blood_donation/ui/notifications/notification.dart';
import 'package:blood_donation/ui/profile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:badges/badges.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;

  const MyAppBar({
    Key? key,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationsBloc(),
      child: AppBar(
        iconTheme: const IconThemeData(color: MyColors.black),
        backgroundColor: MyColors.white,
        title: Text(
          "Dashboard",
          style: MyTextStyles(MyColors.primary).titleTextStyle,
        ),
        elevation: 0,
        actions: [
          BlocBuilder<NotificationsBloc, FetchedNotificationsState>(
            builder: (context, state) {
              int unread = 0;
              for (MyNotification notification in state.notifications) {
                if (notification.status == "unread") {
                  unread++;
                }
              }
              return IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Notifications(),
                    ),
                  );
                },
                icon: Badge(
                  badgeColor: MyColors.primary,
                  badgeContent: Text(
                    unread.toString(),
                    style: MyTextStyles(MyColors.white).badgeTextStyle,
                  ),
                  showBadge: unread != 0,
                  child: const Icon(
                    Icons.notifications_outlined,
                    size: 30,
                  ),
                ),
              );
            },
          ),
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
              backgroundImage: (FirebaseAuth.instance.currentUser!.photoURL !=
                      null)
                  ? NetworkImage(
                      FirebaseAuth.instance.currentUser!.photoURL.toString())
                  : null,
            ),
          ),
          const SizedBox(
            width: MySizes.defaultSpace,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
