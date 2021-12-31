part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AppStartedEvent extends AuthEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OtpSendEvent extends AuthEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoggedInEvent extends AuthEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoggedOutEvent extends AuthEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
