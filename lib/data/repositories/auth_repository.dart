import 'package:firebase_auth/firebase_auth.dart';

abstract class Auth {
  sendOtp(String phone);

  signInWithVerificationId(String verificationId, String otp);

  signInWithCredentials(PhoneAuthCredential phoneAuthCredential);

  signOut(FirebaseAuth firebaseAuth);

  isSignedIn(FirebaseAuth firebaseAuth);
}

class AuthRepository extends Auth {
  final FirebaseAuth firebaseAuth;

  AuthRepository(this.firebaseAuth);

  @override
  sendOtp(String phone) {
    // TODO: implement sendOtp
    throw UnimplementedError();
  }

  @override
  signInWithCredentials(PhoneAuthCredential phoneAuthCredential) {
    // TODO: implement signInWithCredentials
    throw UnimplementedError();
  }

  @override
  signInWithVerificationId(String verificationId, String otp) {
    // TODO: implement signInWithVerificationId
    throw UnimplementedError();
  }

  @override
  signOut(FirebaseAuth firebaseAuth) {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  isSignedIn(FirebaseAuth firebaseAuth) {
    // TODO: implement isSignedIn
    throw UnimplementedError();
  }
}
