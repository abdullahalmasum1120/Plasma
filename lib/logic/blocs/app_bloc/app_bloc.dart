import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:blood_donation/logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthBloc _authBloc;
  late StreamSubscription _authStreamSubscription;

  AppBloc(this._authBloc) : super(AppUnAuthenticatedState()) {
    _authStreamSubscription = _authBloc.stream.listen((state) {
      if (state is OtpVerifiedState) {
        add(AppAuthenticatedEvent());
      }
    });
    on<AppStartedEvent>((event, emit) {
      if (FirebaseAuth.instance.currentUser != null) {
        emit(AppAuthenticatedState());
      } else {
        emit(AppUnAuthenticatedState());
      }
    });
    on<AppAuthenticatedEvent>((event, emit) {
      emit(AppAuthenticatedState());
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
