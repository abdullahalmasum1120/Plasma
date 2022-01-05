import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:blood_donation/data/model/my_user.dart';
import 'package:blood_donation/data/repositories/auth_repository.dart';
import 'package:blood_donation/logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthBloc _authBloc;
  late StreamSubscription _authStreamSubscription;
  final AuthRepository _authRepository = AuthRepository();

  AppBloc(this._authBloc) : super(AppUnAuthenticatedState()) {
    _authStreamSubscription = _authBloc.stream.listen((state) {
      if (state is OtpVerifiedState) {
        add(AppAuthenticatedEvent());
      }
    });
    on<AppStartedEvent>((event, emit) {
      if (_authRepository.isSignedIn()) {
        add(AppAuthenticatedEvent());
      } else {
        add(AppUnAuthenticatedEvent());
      }
    });
    on<AppAuthenticatedEvent>((event, emit) async {
      MyUser _myUser;
      try {
        _myUser = await _authRepository.currentUser;
        if (_myUser.uid != null) {
          emit(AppAuthenticatedState());
        } else {
          emit(AppUserDataUploadState());
        }
      } on FirebaseException catch (e) {
        emit(AppExceptionState(e));
      }
    });
    on<AppUnAuthenticatedEvent>((event, emit) {
      emit(AppUnAuthenticatedState());
    });
  }

  @override
  Future<void> close() {
    _authStreamSubscription.cancel();
    return super.close();
  }
}
