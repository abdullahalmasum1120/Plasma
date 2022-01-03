import 'package:blood_donation/data/model/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepoInterface {
  Future<void> sendOtp({
    required String phone,
    required Duration duration,
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
