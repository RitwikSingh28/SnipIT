import 'dart:convert';

class EmailLoginEntity {
  final String email;
  final String password;

  String userLoginModelToJson(EmailLoginEntity data) =>
      json.encode(data.toJson());

  const EmailLoginEntity({required this.email, required this.password});
  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
