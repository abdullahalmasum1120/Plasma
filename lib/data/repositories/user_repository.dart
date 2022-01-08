import 'package:blood_donation/app/app_config/database.dart';
import 'package:blood_donation/data/interfaces/user_repo_interface.dart';
import 'package:blood_donation/data/model/my_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository extends UserRepoInterface {
  final User user;

  UserRepository({required this.user});

  @override
  Future<MyUser> get currentUserInfo async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await Database.database.collection("users").doc(this.user.uid).get();
    if (snapshot.data() != null) {
      return MyUser.fromJson(snapshot.data()!);
    }
    return MyUser();
  }

  @override
  Future<void> updateUserInfo(MyUser myUser) async {
    this.user.updateDisplayName(myUser.username);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(this.user.uid)
        .set(myUser.toJson());
  }
}
