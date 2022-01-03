import 'package:blood_donation/data/interfaces/form_repo_interface.dart';

class FormRepository extends FormRepoInterface {
  bool isValidateEmail(String email) {
    return super.emailRegEx.hasMatch(email);
  }

  bool isValidatePassword(String password) {
    return super.passwordRegex.hasMatch(password);
  }

  bool isValidatePhone(String phone) {
    return super.phoneRegEx.hasMatch(phone);
  }

  bool isValidateOtp(String otp) {
    return super.otpRegEx.hasMatch(otp);
  }
}
