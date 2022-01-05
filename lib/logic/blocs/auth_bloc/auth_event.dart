part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class OtpSendingEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class AuthInitialEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class OtpVerifiedEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class OtpExceptionEvent extends AuthEvent {
  final FirebaseAuthException firebaseAuthException;

  OtpExceptionEvent(this.firebaseAuthException);

  @override
  List<Object?> get props => [firebaseAuthException];
}

class OtpSentEvent extends AuthEvent {
  final String verificationId;
  final int? forceResendingToken;

  OtpSentEvent(this.verificationId, this.forceResendingToken);

  @override
  List<Object?> get props => [verificationId, forceResendingToken];
}

class OtpTimeOutEvent extends AuthEvent {
  final String verificationId;

  OtpTimeOutEvent(this.verificationId);

  @override
  List<Object?> get props => [verificationId];
}

class OtpVerifyingEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}
