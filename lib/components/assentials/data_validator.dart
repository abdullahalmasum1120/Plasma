class DataValidator {
  static bool isValidateUsername(String username) {
    if (username.length > 3) {
      return true;
    }
    return false;
  }

  static bool isValidateEmail(String email) {
    if (email.contains("@gmail.com")) {
      return true;
    }
    return false;
  }

  static bool isValidatePassword(String password) {
    if (password.length > 5) {
      return true;
    }
    return false;
  }

  static bool isValidatePhone(String phone) {
    if (phone.length == 11) {
      return true;
    }
    return false;
  }

  static bool isValidateBloodGroup(String bloodGroup) {
    if (bloodGroup.length > 1) {
      return true;
    }
    return false;
  }

  static bool isValidateLocation(String location) {
    if (location.length > 10) {
      return true;
    }
    return false;
  }
  static bool isValidateCode(String code) {
    if (code.length == 6) {
      return true;
    }
    return false;
  }
}
