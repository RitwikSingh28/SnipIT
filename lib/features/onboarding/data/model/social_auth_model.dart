// To parse this JSON data, do
//
//     final socialAuthModel = socialAuthModelFromJson(jsonString);

import 'dart:convert';

import 'package:snipit/features/onboarding/data/model/userModel.dart';
import 'package:snipit/features/onboarding/data/model/user_response_model.dart';

class SocialAuthModel {
  bool success;
  String message;
  String token;
  UserModel? user;

  SocialAuthModel(
      {required this.success,
      required this.message,
      required this.token,
      this.user});
  SocialAuthModel socialAuthModelFromJson(String str) =>
      SocialAuthModel.fromJson(json.decode(str));

  String socialAuthModelToJson(SocialAuthModel data) =>
      json.encode(data.toJson());

  factory SocialAuthModel.fromJson(Map<String, dynamic> json) =>
      SocialAuthModel(
          success: json["success"],
          message: json["message"],
          token: json['token'] ?? "",
          user: json['user'] != null ? UserModel.fromMap(json['user']) : null);

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}

class Error {
  String code;
  String message;

  Error({
    required this.code,
    required this.message,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}
