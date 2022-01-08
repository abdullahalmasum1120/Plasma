part of 'form_cubit.dart';

class UserDataFormState extends Equatable {
  final bool isValidLocation;
  final bool isValidEmail;
  final bool isValidName;
  final bool isValidBloodGroup;
  final String selectedBloodGroup;
  final bool isSubmitted;
  final bool isLoading;

  const UserDataFormState({
    this.isValidLocation = false,
    this.isValidEmail = false,
    this.isValidName = false,
    this.isValidBloodGroup = false,
    this.selectedBloodGroup = "",
    this.isSubmitted = false,
    this.isLoading = false,
  });

  UserDataFormState copyWith({
    bool? isValidLocation,
    bool? isValidEmail,
    bool? isValidName,
    bool? isValidBloodGroup,
    String? selectedBloodGroup,
    bool? isSubmitted,
    bool? isLoading,
  }) {
    return UserDataFormState(
      isValidLocation: isValidLocation ?? this.isValidLocation,
      isValidEmail: isValidEmail ?? this.isValidEmail,
      isValidName: isValidName ?? this.isValidName,
      isValidBloodGroup: isValidBloodGroup ?? this.isValidBloodGroup,
      selectedBloodGroup: selectedBloodGroup ?? this.selectedBloodGroup,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        isValidLocation,
        isValidEmail,
        isValidName,
        isValidBloodGroup,
        selectedBloodGroup,
        isSubmitted,
        isLoading,
      ];
}
