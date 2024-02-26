import 'dart:convert';

import 'package:snipit/features/onboarding/data/model/userModel.dart';
import 'package:snipit/features/onboarding/data/model/user_response_model.dart';

class RegisterResponseModel {
  String message;
  bool success;
  UserModel user;

  RegisterResponseModel(
      {required this.message, required this.success, required this.user});

  factory RegisterResponseModel.fromMap(Map<String, dynamic> map) {
    return RegisterResponseModel(
        message: map['message'] ?? 'Error occurred',
        success: map['success'] ?? false,
        user: UserModel.fromMap(map['data']['user']));
  }

  factory RegisterResponseModel.fromJson(String source) =>
      RegisterResponseModel.fromMap(json.decode(source));

  @override
  String toString() => 'RegisterResponseModel(message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegisterResponseModel && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
