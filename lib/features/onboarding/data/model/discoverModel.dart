import 'dart:convert';

class DiscoverCategoryModel {
  String id;
  String title;
  String? categoryId;
  String? subcategoryId;
  String image;
  DiscoverCategoryModel({
    required this.id,
    required this.title,
    this.categoryId,
    this.subcategoryId,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'title': title,
      'categoryId': categoryId,
      'subCategoryId': subcategoryId,
      'image': image,
    };
  }

  factory DiscoverCategoryModel.fromMap(Map<String, dynamic> map) {
    return DiscoverCategoryModel(
      id: map['_id'] ?? '',
      title: map['title'] ?? '',
      categoryId: map['categoryId'] ?? '',
      subcategoryId: map['subCategoryId'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DiscoverCategoryModel.fromJson(String source) =>
      DiscoverCategoryModel.fromMap(json.decode(source));
}
