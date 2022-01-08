import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  late StreamSubscription _userStreamSubscription;

  AppBloc() : super(AppInitialState()) {
    _userStreamSubscription =
        FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        if (user.displayName != null) {
          add(AppAuthenticatedEvent());
        } else {
          add(AppUserDataUploadEvent());
        }
      } else {
        add(AppUnAuthenticatedEvent());
      }
    });
    on<AppAuthenticatedEvent>((event, emit) async {
      emit(AppAuthenticatedState());
    });
    on<AppUnAuthenticatedEvent>((event, emit) {
      emit(AppUnAuthenticatedState());
    });
    on<AppUserDataUploadEvent>((event, emit) {
      emit(AppUserDataUploadState());
    });
  }

  @override
  Future<void> close() {
    _userStreamSubscription.cancel();
    return super.close();
  }
}
