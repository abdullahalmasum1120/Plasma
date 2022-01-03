part of 'form_bloc.dart';

abstract class AuthFormState extends Equatable {
  const AuthFormState();
}

class InitialAuthFormState extends AuthFormState {
  @override
  List<Object?> get props => [];
}

class OtpFormState extends AuthFormState {
  final bool isOtpValid;

  OtpFormState(this.isOtpValid);

  @override
  List<Object?> get props => [isOtpValid];
}

class PhoneFormState extends AuthFormState {
  final bool isValidPhone;

  PhoneFormState(this.isValidPhone);

  @override
  List<Object?> get props => [isValidPhone];
}
