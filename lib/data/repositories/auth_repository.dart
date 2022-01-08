import 'package:blood_donation/data/interfaces/auth_repo_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository extends AuthRepoInterface {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  AuthRepository();

  @override
  Future<void> signOut() {
    return firebaseAuth.signOut();
  }

  @override
  bool isSignedIn() {
    return firebaseAuth.currentUser != null;
  }

  @override
  User? get user => firebaseAuth.currentUser;
}
