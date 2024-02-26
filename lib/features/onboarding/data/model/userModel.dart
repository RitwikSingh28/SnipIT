import 'dart:convert';

import 'package:snipit/features/onboarding/data/model/user_response_model.dart';

class UserModel {
  String id;
  String firstName;
  String userName;
  String lastName;
  String phone;
  bool isProfileComplete;
  String email;
  bool isVerified;
  String? photo;

  String userPreferencesId;
  UserModel({
    required this.id,
    required this.firstName,
    required this.userName,
    required this.lastName,
    required this.phone,
    required this.isProfileComplete,
    required this.email,
    required this.isVerified,
    this.photo,
    required this.userPreferencesId,
  });

  UserModel copyWith({
    AuthConfig? authConfig,
    String? id,
    String? firstName,
    String? userName,
    String? lastName,
    String? phone,
    bool? isProfileComplete,
    String? email,
    bool? isVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userPreferencesId,
  }) {
    return UserModel(
      id: id ?? this.id,
      userName: userName??this.userName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      isProfileComplete: isProfileComplete ?? this.isProfileComplete,
      email: email ?? this.email,
      isVerified: isVerified ?? this.isVerified,
      userPreferencesId: userPreferencesId ?? this.userPreferencesId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      "username":userName,
      'lastName': lastName,
      'phone': phone,
      'isProfileComplete': isProfileComplete,
      'email': email,
      'isVerified': isVerified,
      'profilePicture': photo,
      'userPreferencesId': userPreferencesId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] ?? '',
      photo: map["profilePicture"],
      firstName: map['firstName'] ?? '',
      userName: map["username"]??'',
      lastName: map['lastName'] ?? '',
      phone: map['phone'] ?? '',
      isProfileComplete: map['isProfileComplete'] ?? false,
      email: map['email'] ?? '',
      isVerified: map['isVerified'] ?? false,
      userPreferencesId: map['userPreferencesId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}