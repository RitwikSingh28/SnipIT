import 'dart:convert';

import 'package:snipit/features/feed/data/models/news_model.dart';
import 'package:snipit/features/onboarding/data/model/category_model.dart';

class NewsByCategoryResponse {
  bool success;
  String message;
  List<News> news;
  int total;

  NewsByCategoryResponse({
    required this.success,
    required this.message,
    required this.news,
    required this.total,
  });

  factory NewsByCategoryResponse.fromJson(Map<String, dynamic> json) =>
      NewsByCategoryResponse(
        success: json["success"],
        message: json["message"] ?? "",
        news: json["news"] != null
            ? List<News>.from(json["news"].map((x) => News.fromJson(x)))
            : [],
        total: json["total"]??0,
      );
  NewsByCategoryResponse getNEwsByUserModelFromJson(String str) =>
      NewsByCategoryResponse.fromJson(json.decode(str));

  String getNEwsByUserModelToJson(NewsByCategoryResponse data) =>
      json.encode(data.toJson());

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "news": List<dynamic>.from(news.map((x) => x.toJson())),
        "total": total,
      };
}
