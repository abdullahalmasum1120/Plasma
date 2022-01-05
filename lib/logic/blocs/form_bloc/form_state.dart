part of 'form_bloc.dart';

abstract class AuthFormState extends Equatable {
  const AuthFormState();
}

class AuthOtpFormState extends AuthFormState {
  final bool isOtpValid;
  final bool isValidPhone;

  const AuthOtpFormState({
    this.isOtpValid = false,
    this.isValidPhone = false,
  });

  AuthOtpFormState copyWith({
    bool? isOtpValid,
    bool? isValidPhone,
  }) {
    return AuthOtpFormState(
      isOtpValid: isOtpValid ?? this.isOtpValid,
      isValidPhone: isValidPhone ?? this.isValidPhone,
    );
  }

  @override
  List<Object?> get props => [isValidPhone, isOtpValid];
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
