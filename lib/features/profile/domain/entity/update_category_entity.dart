// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UpdateCategoryEntity {
  final List<String> categories;
  final List<String> subcategories;
  UpdateCategoryEntity({
    required this.categories,
    required this.subcategories,
  });

  String updateCategoryModelToJson(UpdateCategoryEntity data) =>
      json.encode(data.toJson());

  Map<String, dynamic> toJson() => {
        "categories": categories,
        "subcategories": subcategories,
      };
}
