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

class UserDataFormState extends AuthFormState {
  final bool isValidLocation;
  final bool isValidEmail;
  final bool isValidName;

  const UserDataFormState({
    this.isValidLocation = false,
    this.isValidEmail = false,
    this.isValidName = false,
  });

  UserDataFormState copyWith({
    bool? isValidLocation,
    bool? isValidEmail,
    bool? isValidName,
  }) {
    return UserDataFormState(
      isValidLocation: isValidLocation ?? this.isValidLocation,
      isValidEmail: isValidEmail ?? this.isValidEmail,
      isValidName: isValidName ?? this.isValidName,
    );
  }

  @override
  List<Object?> get props => [isValidLocation, isValidEmail, isValidName];
}
