import 'package:blood_donation/data/repositories/form_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'form_event.dart';

part 'form_state.dart';

class AuthFormBloc extends Bloc<AuthFormEvent, AuthFormState> {
  UserDataFormState _userDataFormState = UserDataFormState();
  final FormRepository formValidatorRepository;

  AuthFormBloc(this.formValidatorRepository) : super(InitialAuthFormState()) {
    on<PhoneFormChangedEvent>((event, emit) {
      emit(
          PhoneFormState(formValidatorRepository.isValidatePhone(event.phone)));
    });
    on<OtpFormChangedEvent>((event, emit) {
      emit(OtpFormState(formValidatorRepository.isValidateOtp(event.otp)));
    });
    on<NameFormChangedEvent>((event, emit) {
      _userDataFormState = _userDataFormState.copyWith(
        isValidName: formValidatorRepository.isValidateName(event.name),
      );
      emit(_userDataFormState);
    });
    on<EmailFormChangedEvent>((event, emit) {
      _userDataFormState = _userDataFormState.copyWith(
        isValidEmail: formValidatorRepository.isValidateEmail(event.email),
      );
      emit(_userDataFormState);
    });
    on<LocationFormChangedEvent>((event, emit) {
      _userDataFormState = _userDataFormState.copyWith(
        isValidLocation:
            formValidatorRepository.isValidateLocation(event.location),
      );
      emit(_userDataFormState);
    });
  }
}
