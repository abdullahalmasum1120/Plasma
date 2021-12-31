part of 'app_bloc.dart';

enum AppStatus {
  authenticated,
  unAuthenticated,
  updateUserData,
}

class AppState extends Equatable {
  final AppStatus authStatus;

  const AppState._({required this.authStatus});

  const AppState.authenticated() : this._(authStatus: AppStatus.authenticated);

  const AppState.unAuthenticated()
      : this._(authStatus: AppStatus.unAuthenticated);

  const AppState.updateUserData()
      : this._(authStatus: AppStatus.updateUserData);

  @override
  List<Object?> get props => [authStatus];
}
