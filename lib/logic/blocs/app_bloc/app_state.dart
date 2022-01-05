part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  const AppState();
}

class AppAuthenticatedState extends AppState {
  @override
  List<Object> get props => [];
}

class AppUnAuthenticatedState extends AppState {
  @override
  List<Object> get props => [];
}
