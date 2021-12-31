import 'package:bloc/bloc.dart';
import 'package:blood_donation/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitialState()) {
    on<AuthEvent>((event, emit) {
      //TODO: decide what to emit
    });
  }
}
