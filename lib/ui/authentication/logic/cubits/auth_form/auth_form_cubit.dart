import 'package:bloc/bloc.dart';
import 'package:blood_donation/data/repositories/form_repository.dart';
import 'package:equatable/equatable.dart';

part 'auth_form_state.dart';

class AuthFormCubit extends Cubit<AuthFormState> {
  final FormRepository _formRepository = FormRepository();

  AuthFormCubit() : super(AuthFormState());

  void phoneChanged(String phone) {
    emit(state.copyWith(isValidPhone: _formRepository.isValidatePhone(phone)));
  }

  void otpChanged(String otp) {
    emit(state.copyWith(isOtpValid: _formRepository.isValidateOtp(otp)));
  }
}
