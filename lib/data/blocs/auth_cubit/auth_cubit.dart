import 'package:bloc/bloc.dart';
import 'package:blood_donation/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());

  Future<void> sendOtp(String phone) async {
    emit(LoadingState());
    await authRepository.sendOtp(
        phone: phone,
        phoneVerificationCompleted:
            (PhoneAuthCredential phoneAuthCredential) async {
          UserCredential userCredential =
              await authRepository.signInWithCredentials(phoneAuthCredential);
          emit(SignedInState(userCredential));
        },
        phoneVerificationFailed: (FirebaseAuthException firebaseAuthException) {
          emit(SignInFailed(firebaseAuthException));
        },
        phoneCodeSent: (String verificationId, int? forceResendingToken) async {
          emit(OtpSent(verificationId, forceResendingToken));
        },
        phoneCodeAutoRetrievalTimeout: (String verificationId) {
          emit(OtpTimeOut());
        });
  }
}
