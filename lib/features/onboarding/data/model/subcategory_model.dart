import 'dart:convert';

class SubcategoryModel {
  String id;
  String name;
  String categoryId;
  String image;
  SubcategoryModel({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'title': name,
      'categoryId': categoryId,
      'image': image,
    };
  }

  factory SubcategoryModel.fromMap(Map<String, dynamic> map) {
    return SubcategoryModel(
      id: map['_id'] ?? '',
      name: map['title'] ?? '',
      categoryId: map['categoryId'] ?? '',
      image: map['image'] ?? '',
    );
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SubcategoryModel && other.id == id && other.name == name;
  }

  String toJson() => json.encode(toMap());

  factory SubcategoryModel.fromJson(String source) =>
      SubcategoryModel.fromMap(json.decode(source));
}
