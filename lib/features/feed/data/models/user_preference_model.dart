import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:snipit/features/onboarding/data/model/category_model.dart';
import 'package:snipit/features/onboarding/data/model/discoverModel.dart';
import 'package:snipit/features/onboarding/data/model/subcategory_model.dart';

class UserPreferenceModel extends Equatable {
  String id;
  String userId;
  List<CategoryModel> categories;
  List<SubcategoryModel> subcategories;
  List<DiscoverCategoryModel> discoverCategories;
  UserPreferenceModel(
      {required this.id,
      required this.userId,
      required this.categories,
      required this.subcategories,
      required this.discoverCategories});

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'userId': userId,
      'categories': categories.map((x) => x.toMap()).toList(),
      'subCategories': subcategories.map((x) => x.toMap()).toList(),
      'discoverCategories': discoverCategories.map((e) => e.toMap()).toList()
    };
  }

  factory UserPreferenceModel.fromMap(Map<String, dynamic> map) {
    return UserPreferenceModel(
        id: map['_id'] ?? '',
        userId: map['userId'] ?? '',
        categories: map['categories'] == null
            ? []
            : List<CategoryModel>.from(
                map['categories']?.map((x) => CategoryModel.fromMap(x))),
        subcategories: map['subCategories'] == null
            ? []
            : List<SubcategoryModel>.from(
                map['subCategories']?.map((x) => SubcategoryModel.fromMap(x))),
        discoverCategories: map['discoverCategories'] == null
            ? []
            : List<DiscoverCategoryModel>.from(map['discoverCategories']
                ?.map((x) => DiscoverCategoryModel.fromMap(x))));
  }

  String toJson() => json.encode(toMap());

  factory UserPreferenceModel.fromJson(String source) =>
      UserPreferenceModel.fromMap(json.decode(source));

  @override
  List<Object?> get props => [id, userId, categories, subcategories];
}
