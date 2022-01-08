part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
}

class AppAuthenticatedEvent extends AppEvent {
  @override
  List<Object?> get props => [];
}

class AppUnAuthenticatedEvent extends AppEvent {
  @override
  List<Object?> get props => [];
}

class AppUserDataUploadEvent extends AppEvent {
  @override
  List<Object?> get props => [];
}
