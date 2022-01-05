part of 'user_data_cubit.dart';

class UserDataFormState extends Equatable {
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