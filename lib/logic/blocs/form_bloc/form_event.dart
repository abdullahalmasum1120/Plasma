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
class NameFormChangedEvent extends AuthFormEvent {
  final String name;

  const NameFormChangedEvent({required this.name});

  @override
  List<Object> get props => [name];
}
class EmailFormChangedEvent extends AuthFormEvent {
  final String email;

  const EmailFormChangedEvent({required this.email});

  @override
  List<Object> get props => [email];
}
class LocationFormChangedEvent extends AuthFormEvent {
  final String location;

  const LocationFormChangedEvent({required this.location});

  @override
  List<Object> get props => [location];
}
