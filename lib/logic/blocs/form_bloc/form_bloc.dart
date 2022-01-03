import 'package:blood_donation/data/repositories/form_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'form_event.dart';

part 'form_state.dart';

class AuthFormBloc extends Bloc<AuthFormEvent, AuthFormState> {
  final FormRepository formValidatorRepository;

  AuthFormBloc(this.formValidatorRepository) : super(InitialAuthFormState()) {
    on<PhoneFormChangedEvent>((event, emit) {
      emit(
          PhoneFormState(formValidatorRepository.isValidatePhone(event.phone)));
    });
    on<OtpFormChangedEvent>((event, emit) {
      emit(OtpFormState(formValidatorRepository.isValidateOtp(event.otp)));
    });
  }
}
