part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  const AppState();
}

class AppInitialState extends AppState {
  @override
  List<Object> get props => [];
}

class AppAuthenticatedState extends AppState {
  @override
  List<Object> get props => [];
}

class AppUnAuthenticatedState extends AppState {
  @override
  List<Object> get props => [];
}

class AppUserDataUploadState extends AppState {
  @override
  List<Object> get props => [];
}

class AppExceptionState extends AppState {
  final FirebaseException _firebaseException;

  AppExceptionState(this._firebaseException);

  @override
  List<Object> get props => [_firebaseException];
}
