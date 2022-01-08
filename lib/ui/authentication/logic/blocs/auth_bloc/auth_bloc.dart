import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Duration _timeOutDuration = Duration(minutes: 2);

  AuthBloc() : super(AuthInitialState()) {
    on<OtpVerifyingEvent>((event, emit) async {
      emit(OtpVerifyingState());
    });

    on<OtpSendingEvent>((event, emit) {
      emit(OtpSendingState());
    });
    on<OtpExceptionEvent>((event, emit) {
      emit(OtpExceptionState(event.firebaseAuthException));
    });

    on<OtpSentEvent>((event, emit) {
      emit(OtpSentState(event.verificationId, event.forceResendingToken));
    });

    on<OtpTimeOutEvent>((event, emit) {
      emit(OtpTimeOutState(event.verificationId));
    });
    on<AuthInitialEvent>((event, emit) {
      emit(AuthInitialState());
    });
    on<OtpVerifiedEvent>((event, emit) {
      emit(OtpVerifiedState());
    });
  }

  Future<void> sendOtp({
    required String phone,
  }) async {
    try {
      add(OtpSendingEvent());
      await _firebaseAuth.verifyPhoneNumber(
          timeout: _timeOutDuration,
          phoneNumber: "+88${phone}",
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            try {
              await _firebaseAuth.signInWithCredential(phoneAuthCredential);
              add(OtpVerifiedEvent());
            } on FirebaseAuthException catch (e) {
              add(OtpExceptionEvent(e));
            }
          },
          verificationFailed: (FirebaseAuthException firebaseAuthException) {
            add(OtpExceptionEvent(firebaseAuthException));
          },
          codeSent: (String verificationId, int? forceResendingToken) {
            add(OtpSentEvent(verificationId, forceResendingToken));
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            add(OtpTimeOutEvent(verificationId));
          });
    } on FirebaseAuthException catch (e) {
      add(OtpExceptionEvent(e));
    }
  }

  Future<void> verifyOtp({
    required String otp,
    required String verificationId,
  }) async {
    try {
      add(OtpVerifyingEvent());
      await _firebaseAuth.signInWithCredential(PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp));
      add(OtpVerifiedEvent());
    } on FirebaseAuthException catch (e) {
      add(OtpExceptionEvent(e));
    }
  }
}
