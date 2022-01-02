part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class SendOtpEvent extends AuthEvent {
  final String phone;

  SendOtpEvent(this.phone);

  @override
  List<Object?> get props => [phone];
}

class OtpSendingEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class AuthenticatedEvent extends AuthEvent {
  final UserCredential userCredential;

  AuthenticatedEvent(this.userCredential);

  @override
  List<Object?> get props => [userCredential];
}

class AuthenticationFailedEvent extends AuthEvent {
  final FirebaseAuthException firebaseAuthException;

  AuthenticationFailedEvent(this.firebaseAuthException);

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

class VerifyOtpEvent extends AuthEvent {
  final String verificationId;
  final String otp;

  VerifyOtpEvent(this.verificationId, this.otp);

  @override
  List<Object?> get props => [otp, verificationId];
}
