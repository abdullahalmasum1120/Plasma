abstract class FormRepoInterface {
  final RegExp phoneRegEx = RegExp(r'^01[13-9]\d{8}$');
  final RegExp emailRegEx = RegExp(r'^[a-z0-9](\.?[a-z0-9]){5,}@gmail\.com$');
  final RegExp locationRegex = RegExp(r'^[a-zA-Z ,-]{3,50}$');
  final RegExp otpRegEx = RegExp(r'^\d{6}$');
  final RegExp nameRegEx = RegExp(r'^[a-zA-Z ]{3,20}$');

  bool isValidateEmail(String email);

  bool isValidateLocation(String location);

  bool isValidatePhone(String phone);

  bool isValidateOtp(String otp);

  bool isValidateName(String name);

  bool isValidBloodGroup(String bloodGroup);
}
