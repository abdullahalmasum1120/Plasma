part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitialState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthenticatedState extends AuthState {
  @override
  List<Object> get props => [];
}

class UserInfoUpdateState extends AuthState {
  @override
  List<Object> get props => [];
}
