// To parse this JSON data, do
//
//     final userResponseModel = userResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:snipit/features/onboarding/data/model/userModel.dart';

UserResponseModel userResponseModelFromJson(String str) =>
    UserResponseModel.fromJson(json.decode(str));

String userResponseModelToJson(UserResponseModel data) =>
    json.encode(data.toJson());

class UserResponseModel {
  bool success;
  String message;
  String token;
  UserModel user;

  UserResponseModel({
    required this.success,
    required this.message,
    required this.token,
    required this.user,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      UserResponseModel(
        success: json["success"],
        message: json["message"],
        token: json["token"],
        user: UserModel.fromMap(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "token": token,
        "user": user.toJson(),
      };
}

class AuthConfig {
  String provider;

  AuthConfig({
    required this.provider,
  });

  factory AuthConfig.fromJson(Map<String, dynamic> json) => AuthConfig(
        provider: json["provider"],
      );

  Map<String, dynamic> toJson() => {
        "provider": provider,
      };
}
