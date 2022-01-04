import 'package:blood_donation/data/interfaces/user_repo_interface.dart';
import 'package:blood_donation/data/model/my_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository extends UserRepoInterface {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<MyUser> get currentUser async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .get();
    if (snapshot.data() != null) {
      return MyUser.fromJson(snapshot.data()!);
    }
    return MyUser();
  }

  @override
  Future<bool> updateUserInfo(MyUser user) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(user.toJson());

    return true;
  }
}
