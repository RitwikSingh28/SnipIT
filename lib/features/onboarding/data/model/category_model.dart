// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CategoryModel {
  final String name;
  final String image;
  final String id;

  CategoryModel({
    required this.name,
    required this.image,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': name,
      'image': image,
      '_id': id,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      name: map['title'] ?? '',
      image: map['image'] ?? '',
      id: map['_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CategoryModel && other.id == id && other.name == name;
  }

  @override
  String toString() => 'CategoryModel(name: $name, image: $image, id: $id)';
}
