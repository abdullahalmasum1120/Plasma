part of 'form_bloc.dart';

abstract class AuthFormEvent extends Equatable {
  const AuthFormEvent();

  @override
  List<Object> get props => [];
}

class PhoneFormChangedEvent extends AuthFormEvent {
  final String phone;

  const PhoneFormChangedEvent({required this.phone});

  @override
  List<Object> get props => [phone];
}

class OtpFormChangedEvent extends AuthFormEvent {
  final String otp;

  const OtpFormChangedEvent({required this.otp});

  @override
  List<Object> get props => [otp];
}
