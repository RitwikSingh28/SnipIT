import 'package:email_validator/email_validator.dart';

class Validators {
  static String? email_phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'required.';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required';
    }
    if (!EmailValidator.validate(value.trim())) {
      return 'Invalid Email';
    }
    return null;
  }

  static confirmPassword(String password, String confirmPassword) {
    if (confirmPassword == null || confirmPassword.trim().isEmpty) {
      return "Confirm Password is required";
    }
    return password == confirmPassword ? null : "Passwords do not match";
  }

  static String? password(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required';
    }
    return null;
  }

  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required';
    }
    return null;
  }
  static String? username(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required';
    }
    else if(value.length<5){
      return 'Username must contains atleast 5 characters';
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required';
    }
    if (value.trim().length != 10) {
      return 'Invalid phone number';
    }
    return null;
  }
}
