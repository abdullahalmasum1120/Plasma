import 'package:bloc/bloc.dart';
import 'package:blood_donation/data/model/my_user.dart';
import 'package:blood_donation/data/repositories/form_repository.dart';
import 'package:blood_donation/data/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'form_state.dart';

class UserDataFormCubit extends Cubit<UserDataFormState> {
  final FormRepository _formRepository = FormRepository();

  UserDataFormCubit() : super(UserDataFormState());

  void nameChanged(String name) {
    emit(state.copyWith(
      isValidName: _formRepository.isValidateName(name),
    ));
  }

  void emailChanged(String email) {
    emit(state.copyWith(
      isValidEmail: _formRepository.isValidateEmail(email),
    ));
  }

  void locationChanged(String location) {
    emit(state.copyWith(
      isValidLocation: _formRepository.isValidateLocation(location),
    ));
  }

  void bloodGroupChanged(String bloodGroup) {
    emit(state.copyWith(
      isValidBloodGroup: _formRepository.isValidBloodGroup(bloodGroup),
      selectedBloodGroup: bloodGroup,
    ));
  }

  Future<void> formSubmitted(MyUser myUser) async {
    emit(state.copyWith(isLoading: true));
    await UserRepository(user: FirebaseAuth.instance.currentUser!)
        .updateUserInfo(myUser);
    emit(state.copyWith(isSubmitted: true, isLoading: false));
  }
}
