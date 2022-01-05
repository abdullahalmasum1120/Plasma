part of '../../cubits/auth_form/auth_form_cubit.dart';

class AuthFormState extends Equatable {
  final bool isOtpValid;
  final bool isValidPhone;

  const AuthFormState({
    this.isOtpValid = false,
    this.isValidPhone = false,
  });

  AuthFormState copyWith({
    bool? isOtpValid,
    bool? isValidPhone,
  }) {
    return AuthFormState(
      isOtpValid: isOtpValid ?? this.isOtpValid,
      isValidPhone: isValidPhone ?? this.isValidPhone,
    );
  }

  @override
  List<Object?> get props => [isValidPhone, isOtpValid];
}
