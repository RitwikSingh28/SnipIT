import 'dart:convert';

class VerifyEmailResponse {
  String message;
  bool status;
  VerifyEmailResponse(
      {required this.message,required this.status});

  Map<String, dynamic> toMap() {
    return {'message': message,};
  }

  factory VerifyEmailResponse.fromMap(Map<String, dynamic> map) {
    return VerifyEmailResponse(
        message: map['message'] ?? '',
        status: map['success'] ?? false);
  }

  String toJson() => json.encode(toMap());

  factory VerifyEmailResponse.fromJson(String source) =>
      VerifyEmailResponse.fromMap(json.decode(source));

}
