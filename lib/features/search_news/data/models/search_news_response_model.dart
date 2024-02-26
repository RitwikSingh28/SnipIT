import 'dart:convert';

import 'package:snipit/features/feed/data/models/news_model.dart';
import 'package:snipit/features/onboarding/data/model/category_model.dart';

class SearchNewsResponse {
  bool success;
  String message;
  List<News> news;
  int total;

  SearchNewsResponse({
    required this.success,
    required this.message,
    required this.news,
    required this.total,
  });

  factory SearchNewsResponse.fromJson(Map<String, dynamic> json) =>
      SearchNewsResponse(
        success: json["success"],
        message: json["message"] ?? "",
        news: json["data"]["news"] != null
            ? List<News>.from(json["data"]["news"].map((x) => News.fromJson(x)))
            : [],
        total: json["data"]["total"]??0,
      );
  SearchNewsResponse getNEwsByUserModelFromJson(String str) =>
      SearchNewsResponse.fromJson(json.decode(str));

  String getNEwsByUserModelToJson(SearchNewsResponse data) =>
      json.encode(data.toJson());

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "news": List<dynamic>.from(news.map((x) => x.toJson())),
    "total": total,
  };
}
