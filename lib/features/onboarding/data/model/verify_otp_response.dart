import 'dart:convert';

class VerifyOtpResponse {
  String message;
  String token;
  bool status;
  VerifyOtpResponse(
      {required this.message, required this.token, required this.status});

  Map<String, dynamic> toMap() {
    return {'message': message, 'token': token};
  }

  factory VerifyOtpResponse.fromMap(Map<String, dynamic> map) {
    return VerifyOtpResponse(
        message: map['message'] ?? '',
        token: map['token'] ?? '',
        status: map['success'] ?? false);
  }

  String toJson() => json.encode(toMap());

  factory VerifyOtpResponse.fromJson(String source) =>
      VerifyOtpResponse.fromMap(json.decode(source));

  @override
  String toString() => 'VerifyOtpResponse(message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VerifyOtpResponse && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
