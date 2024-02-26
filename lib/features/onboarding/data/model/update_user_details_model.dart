// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final updateUserDetailsModel = updateUserDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:snipit/features/onboarding/data/model/userModel.dart';

class UpdateUserDetailsModel {

  String message;
  UserModel user;
  UpdateUserDetailsModel({
    required this.message,
    required this.user,
  });
  UpdateUserDetailsModel copyWith({
    String? message,
    UserModel? user,
  }) {
    return UpdateUserDetailsModel(
      message: message ?? this.message,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'user': user.toJson(),
    };
  }

  factory UpdateUserDetailsModel.fromMap(Map<String, dynamic> map) {
    return UpdateUserDetailsModel(
      message: map['message'] ?? '',
      user: UserModel.fromMap(map["data"]['user']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateUserDetailsModel.fromJson(String source) => UpdateUserDetailsModel.fromMap(json.decode(source));

  @override
  String toString() => 'UpdateUserDetailsModel(message: $message, user: $user)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UpdateUserDetailsModel &&
      other.message == message &&
      other.user == user;
  }

  
}

