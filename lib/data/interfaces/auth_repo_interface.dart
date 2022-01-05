import 'package:blood_donation/data/model/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepoInterface {
  Future<void> signOut();

  bool isSignedIn();

  Future<MyUser> get currentUser;
}
