import 'package:blood_donation/data/interfaces/auth_repo_interface.dart';
import 'package:blood_donation/data/model/my_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository extends AuthRepoInterface {
  final FirebaseAuth firebaseAuth;

  AuthRepository(this.firebaseAuth);

  @override
  Future<void> sendOtp({
    required String phone,
    required Duration duration,
    required PhoneVerificationCompleted phoneVerificationCompleted,
    required PhoneVerificationFailed phoneVerificationFailed,
    required PhoneCodeSent phoneCodeSent,
    required PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout,
  }) {
    return firebaseAuth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: duration,
      verificationCompleted: phoneVerificationCompleted,
      verificationFailed: phoneVerificationFailed,
      codeSent: phoneCodeSent,
      codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout,
    );
  }

  @override
  Future<UserCredential> signInWithCredentials(
      PhoneAuthCredential phoneAuthCredential) {
    return firebaseAuth.signInWithCredential(phoneAuthCredential);
  }

  @override
  Future<UserCredential> signInWithVerificationId(
      String verificationId, String otp) {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otp);
    return signInWithCredentials(phoneAuthCredential);
  }

  @override
  Future<void> signOut() {
    return firebaseAuth.signOut();
  }

  @override
  bool isSignedIn() {
    return firebaseAuth.currentUser != null;
  }

  @override
  Future<MyUser> get currentUser async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .get();
    return MyUser.fromJson(snapshot.data()!);
  }
}
