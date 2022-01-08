part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitialState extends AuthState {
  @override
  List<Object> get props => [];
}

class OtpExceptionState extends AuthState {
  final FirebaseAuthException firebaseAuthException;

  OtpExceptionState(this.firebaseAuthException);

  @override
  List<Object> get props => [firebaseAuthException];
}

class OtpSentState extends AuthState {
  final String verificationId;
  final int? forceResendingToken;

  OtpSentState(this.verificationId, this.forceResendingToken);

  @override
  List<Object> get props => [verificationId, forceResendingToken ?? 0];
}

class OtpTimeOutState extends AuthState {
  final String verificationId;

  OtpTimeOutState(this.verificationId);

  @override
  List<Object> get props => [verificationId];
}

class OtpSendingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class OtpVerifyingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class OtpVerifiedState extends AuthState {
  @override
  List<Object?> get props => [];
}
