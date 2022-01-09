import 'package:blood_donation/components/constant/colors.dart';
import 'package:blood_donation/components/constant/styles.dart';
import 'package:blood_donation/ui/home/logic/blocs/notifications_bloc/notifications_bloc.dart';
import 'package:blood_donation/ui/profile/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class Notifications extends StatelessWidget {
  Notifications({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationsBloc(),
      child: BlocBuilder<NotificationsBloc, FetchedNotificationsState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: MyColors.white,
            appBar: AppBar(
              iconTheme: const IconThemeData(
                color: MyColors.primary,
              ),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                "Notifications",
                style: MyTextStyles(MyColors.primary).titleTextStyle,
              ),
            ),
            body: ListView.builder(
              itemCount: state.notifications.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("receivedRequests")
                        .doc(state.notifications[index].docId)
                        .update({"status": "read"});

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Profile(uid: state.notifications[index].uid!);
                    }));
                  },
                  child: ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: (state.notifications[index].status == "unread")
                            ? Border.all(
                                color: MyColors.primary,
                                width: 3,
                              )
                            : null,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/donate.svg",
                      ),
                    ),
                    title: Text(
                      "Someone Requested you to Donate Blood",
                      style: MyTextStyles(MyColors.black).defaultTextStyle,
                    ),
                    subtitle: Text(
                        "${state.notifications[index].time} : ${state.notifications[index].date}"),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
