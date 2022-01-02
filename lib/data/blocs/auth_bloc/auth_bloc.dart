import 'package:bloc/bloc.dart';
import 'package:blood_donation/data/model/my_user.dart';
import 'package:blood_donation/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository)
      : super(authRepository.isSignedIn()
            ? AuthenticatedState()
            : AuthInitial()) {
    on<SendOtpEvent>((event, emit) async {
      add(OtpSendingEvent());
      await authRepository.sendOtp(
          phone: "+88${event.phone}",
          phoneVerificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            UserCredential userCredential =
                await authRepository.signInWithCredentials(phoneAuthCredential);
            add(AuthenticatedEvent(userCredential));
          },
          phoneVerificationFailed:
              (FirebaseAuthException firebaseAuthException) {
            add(AuthenticationFailedEvent(firebaseAuthException));
          },
          phoneCodeSent: (String verificationId, int? forceResendingToken) {
            add(OtpSentEvent(verificationId, forceResendingToken));
          },
          phoneCodeAutoRetrievalTimeout: (String verificationId) {
            add(OtpTimeOutEvent(verificationId));
          });
    });

    on<AuthenticatedEvent>((event, emit) async {
      MyUser myUser = await authRepository.currentUser;
      if (myUser.uid != null) {
        emit(AuthenticatedState());
      } else {
        emit(UpdateUserDataState());
      }
    });
    on<OtpSendingEvent>((event, emit) {
      emit(OtpSendingState());
    });
    on<AuthenticationFailedEvent>((event, emit) {
      emit(AuthenticationFailedState(event.firebaseAuthException));
    });

    on<OtpSentEvent>((event, emit) {
      emit(OtpSentState(event.verificationId, event.forceResendingToken));
    });

    on<OtpTimeOutEvent>((event, emit) {
      emit(OtpTimeOutState(event.verificationId));
    });
    on<VerifyOtpEvent>((event, emit) async {
      emit(OtpVerifyingState());
      UserCredential userCredential = await authRepository
          .signInWithVerificationId(event.verificationId, event.otp);
      add(AuthenticatedEvent(userCredential));
    });
  }
}
