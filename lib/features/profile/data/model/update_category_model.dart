// To parse this JSON data, do
//
//     final updateCategoryModel = updateCategoryModelFromJson(jsonString);

import 'dart:convert';

import 'package:snipit/features/feed/data/models/user_preference_model.dart';

class UpdateCategoryModel {
  bool success;
  String message;
  UserPreferenceModel preferences;

  UpdateCategoryModel(
      {required this.success,
      required this.message,
      required this.preferences});
  UpdateCategoryModel updateCategoryModelFromJson(String str) =>
      UpdateCategoryModel.fromJson(json.decode(str));

  factory UpdateCategoryModel.fromJson(Map<String, dynamic> json) =>
      UpdateCategoryModel(
          success: json["success"],
          message: json["message"],
          preferences: UserPreferenceModel.fromMap(json["updatedPreferences"]));
  String updateCategoryModelToJson(UpdateCategoryModel data) =>
      json.encode(data.toJson());

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
