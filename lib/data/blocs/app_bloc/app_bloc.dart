import 'package:bloc/bloc.dart';
import 'package:blood_donation/data/model/my_user.dart';
import 'package:blood_donation/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthRepository _authRepository;

  AppBloc(this._authRepository)
      : super(_authRepository.isSignedIn()
            ? AppState.updateUserData()
            : AppState.unAuthenticated()) {
    on<AuthenticatedEvent>((event, emit) async {
      MyUser myUser = await _authRepository.currentUser;
      if (myUser.uid != null) {
        emit.call(AppState.authenticated());
      } else {
        emit.call(AppState.updateUserData());
      }
    });
  }
}
