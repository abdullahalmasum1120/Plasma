part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class SignedInState extends AuthState {
  final UserCredential userCredential;

  SignedInState(this.userCredential);

  @override
  List<Object> get props => [userCredential];
}

class SignInFailed extends AuthState {
  final FirebaseAuthException firebaseAuthException;

  SignInFailed(this.firebaseAuthException);

  @override
  List<Object> get props => [firebaseAuthException];
}

class OtpSent extends AuthState {
  final String verificationId;
  final int? forceResendingToken;

  OtpSent(this.verificationId, this.forceResendingToken);

  @override
  List<Object> get props => [verificationId, forceResendingToken ?? 0];
}

class OtpTimeOut extends AuthState {
  @override
  List<Object> get props => [];
}

class LoadingState extends AuthState {
  @override
  List<Object> get props => [];
}
