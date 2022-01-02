import 'package:blood_donation/data/model/my_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthProvider {
  Future<void> sendOtp({
    required String phone,
    required PhoneVerificationCompleted phoneVerificationCompleted,
    required PhoneVerificationFailed phoneVerificationFailed,
    required PhoneCodeSent phoneCodeSent,
    required PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout,
  });

  Future<UserCredential> signInWithVerificationId(
      String verificationId, String otp);

  Future<UserCredential> signInWithCredentials(
      PhoneAuthCredential phoneAuthCredential);

  Future<void> signOut();

  bool isSignedIn();

  Future<MyUser> get currentUser;
}

class AuthRepository extends AuthProvider {
  final FirebaseAuth firebaseAuth;

  AuthRepository(this.firebaseAuth);

  @override
  Future<void> sendOtp({
    required String phone,
    required PhoneVerificationCompleted phoneVerificationCompleted,
    required PhoneVerificationFailed phoneVerificationFailed,
    required PhoneCodeSent phoneCodeSent,
    required PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout,
  }) {
    return firebaseAuth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(minutes: 2),
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
