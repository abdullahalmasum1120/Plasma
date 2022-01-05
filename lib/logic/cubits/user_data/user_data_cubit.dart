import 'package:bloc/bloc.dart';
import 'package:blood_donation/data/repositories/form_repository.dart';
import 'package:equatable/equatable.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataFormState> {
  final FormRepository _formRepository = FormRepository();

  UserDataCubit() : super(UserDataFormState());

  void nameChanged(String name) {
    emit(state.copyWith(isValidName: _formRepository.isValidateName(name)));
  }

  void emailChanged(String email) {
    emit(state.copyWith(isValidEmail: _formRepository.isValidateEmail(email)));
  }

  void locationChanged(String location) {
    emit(state.copyWith(
        isValidLocation: _formRepository.isValidateLocation(location)));
  }
}
