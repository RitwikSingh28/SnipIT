// To parse this JSON data, do
//
//     final likeNewsById = likeNewsByIdFromJson(jsonString);

import 'dart:convert';

class LikeNewsByIdModel {
  bool success;
  String message;

  LikeNewsByIdModel({
    required this.success,
    required this.message,
  });

  factory LikeNewsByIdModel.fromJson(Map<String, dynamic> json) =>
      LikeNewsByIdModel(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };

  LikeNewsByIdModel likeNewsByIdFromJson(String str) =>
      LikeNewsByIdModel.fromJson(json.decode(str));

  String likeNewsByIdToJson(LikeNewsByIdModel data) =>
      json.encode(data.toJson());
}
