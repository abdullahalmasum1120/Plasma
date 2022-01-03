abstract class FormRepoInterface {
  final RegExp phoneRegEx = RegExp(r'^(?:\+?88)?01[13-9]\d{8}$');
  final RegExp emailRegEx = RegExp(r'^[a-z0-9](\.?[a-z0-9]){5,}@gmail\.com$');
  final RegExp passwordRegex =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
  final RegExp otpRegEx = RegExp(r'^\d{6}$');

  bool isValidateEmail(String email);

  bool isValidatePassword(String password);

  bool isValidatePhone(String phone);

  bool isValidateOtp(String otp);
}
