import 'dart:convert';

class ChangePasswordEntity {
  String email;
  String password;
  String confirmPassword;
  String otp;

  ChangePasswordEntity({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.otp,
  });

  String changePasswordModelToJson(ChangePasswordEntity data) =>
      json.encode(data.toJson());


  Map<String, dynamic> toJson() => {
    "email": email,
    "password":password,
    "confirmPassword":confirmPassword,
    "otp":otp
  };
}
