import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:snipit/features/onboarding/data/model/subcategory_model.dart';

class SubCategoryResponseModel {
  List<SubcategoryModel> subCategories;
  SubCategoryResponseModel({
    required this.subCategories,
  });

  SubCategoryResponseModel copyWith({
    List<SubcategoryModel>? subCategories,
  }) {
    return SubCategoryResponseModel(
      subCategories: subCategories ?? this.subCategories,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subCategories': subCategories.map((x) => x.toMap()).toList(),
    };
  }

  factory SubCategoryResponseModel.fromMap(Map<String, dynamic> map) {
    return SubCategoryResponseModel(
      subCategories: List<SubcategoryModel>.from(
          map['subCategories']?.map((x) => SubcategoryModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory SubCategoryResponseModel.fromJson(String source) =>
      SubCategoryResponseModel.fromMap(json.decode(source));
}
