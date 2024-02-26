import 'dart:convert';

class VerifyOtpEntity {
  String email;
  String otp;
  VerifyOtpEntity({
    required this.email,
    required this.otp,
  });

  VerifyOtpEntity copyWith({
    String? email,
    String? otp,
  }) {
    return VerifyOtpEntity(
      email: email ?? this.email,
      otp: otp ?? this.otp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'otp': otp,
    };
  }

  factory VerifyOtpEntity.fromMap(Map<String, dynamic> map) {
    return VerifyOtpEntity(
      email: map['email'] ?? '',
      otp: map['otp'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory VerifyOtpEntity.fromJson(String source) =>
      VerifyOtpEntity.fromMap(json.decode(source));
}
