import 'package:blood_donation/components/constant/colors.dart';
import 'package:blood_donation/components/constant/styles.dart';
import 'package:blood_donation/components/dialogs/loading.dart';
import 'package:blood_donation/model/received_request.dart';
import 'package:blood_donation/pages/profile/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Notifications extends StatelessWidget {
  const Notifications({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ReceivedRequest> receivedRequests = <ReceivedRequest>[];
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
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
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

            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text("No Notifications"),
              );
            }
            //populate List of notifications
            for (var element in snapshot.data!.docs) {
              receivedRequests.add(ReceivedRequest.fromJson(element.data()));
            }
            return ListView.builder(
                itemCount: receivedRequests.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      try {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return const Loading();
                          },
                        );
                        //mark as read
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("receivedRequests")
                            .doc(receivedRequests[index].docId)
                            .update({"status": "read"});
                        //close dialog
                        Navigator.pop(context);
                        //navigate to page
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Profile(uid: receivedRequests[index].uid!);
                        }));
                      } on FirebaseException catch (e) {
                        Get.snackbar("Warning!", e.code);
                      }
                    },
                    child: ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: (receivedRequests[index].status == "unread")
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
                          "${receivedRequests[index].time} : ${receivedRequests[index].date}"),
                    ),
                  );
                });
          }),
    );
  }
}
