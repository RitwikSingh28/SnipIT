// To parse this JSON data, do
//
//     final GetMyDiscoveryThemesModelClass = GetMyDiscoveryThemesModelClassFromJson(jsonString);

import 'dart:convert';

import 'package:snipit/features/onboarding/data/model/category_model.dart';
import 'package:snipit/features/onboarding/data/model/subcategory_model.dart';

class GetMyDiscoveryThemesModelClass {
  bool success;
  String message;
  int totalSelectedDiscoverThemes;
  List<DiscoverTheme> discoverThemes;

  GetMyDiscoveryThemesModelClass({
    required this.success,
    required this.message,
    required this.totalSelectedDiscoverThemes,
    required this.discoverThemes,
  });
  GetMyDiscoveryThemesModelClass GetMyDiscoveryThemesModelClassFromJson(
          String str) =>
      GetMyDiscoveryThemesModelClass.fromJson(json.decode(str));

  String GetMyDiscoveryThemesModelClassToJson(
          GetMyDiscoveryThemesModelClass data) =>
      json.encode(data.toJson());

  factory GetMyDiscoveryThemesModelClass.fromJson(Map<String, dynamic> json) =>
      GetMyDiscoveryThemesModelClass(
        success: json["success"],
        message: json["message"],
        totalSelectedDiscoverThemes: json["totalSelectedDiscoverThemes"],
        discoverThemes: List<DiscoverTheme>.from(
            json["discoverThemes"].map((x) => DiscoverTheme.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "totalSelectedDiscoverThemes": totalSelectedDiscoverThemes,
        "discoverThemes":
            List<dynamic>.from(discoverThemes.map((x) => x.toJson())),
      };
}

class DiscoverTheme {
  String id;
  String title;
  CategoryModel? category;
  SubcategoryModel? subCategory;
  String imageUrl;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool isEnabled;

  DiscoverTheme({
    required this.id,
    required this.title,
    this.category,
    this.subCategory,
    this.createdAt,
    required this.imageUrl,
    this.updatedAt,
    this.isEnabled = false,
  });

  factory DiscoverTheme.fromJson(Map<String, dynamic> json) => DiscoverTheme(
        id: json["_id"],
        title: json["title"],
        category: CategoryModel.fromMap(json["categoryId"]),
        subCategory: SubcategoryModel.fromMap(json["subCategoryId"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        imageUrl: json["image"] ?? "",
        isEnabled: json["isEnabled"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "categoryId": category,
        "subCategoryId": subCategory,
        "isEnabled": isEnabled,
      };
}
