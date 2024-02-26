import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:snipit/features/discover/data/models/get_my_discovery_themes.dart';

class DiscoverResponseModel {
  bool success;
  String message;
  List<DiscoverThemeModel> discoverThemes;
  DiscoverResponseModel({
    required this.success,
    required this.message,
    required this.discoverThemes,
  });

  DiscoverResponseModel copyWith({
    bool? success,
    String? message,
    List<DiscoverThemeModel>? discoverThemes,
  }) {
    return DiscoverResponseModel(
      success: success ?? this.success,
      message: message ?? this.message,
      discoverThemes: discoverThemes ?? this.discoverThemes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'message': message,
      'discoverThemes': discoverThemes.map((x) => x.toMap()).toList(),
    };
  }

  factory DiscoverResponseModel.fromMap(Map<String, dynamic> map) {
    return DiscoverResponseModel(
      success: map['success'] ?? false,
      message: map['message'] ?? '',
      discoverThemes: List<DiscoverThemeModel>.from(
          map['discoverThemes']?.map((x) => DiscoverThemeModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory DiscoverResponseModel.fromJson(String source) =>
      DiscoverResponseModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'DiscoverResponseModel(success: $success, message: $message, discoverThemes: $discoverThemes)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DiscoverResponseModel &&
        other.success == success &&
        other.message == message &&
        listEquals(other.discoverThemes, discoverThemes);
  }

  @override
  int get hashCode =>
      success.hashCode ^ message.hashCode ^ discoverThemes.hashCode;
}

class DiscoverThemeModel {
  String subCategoryName;
  List<DiscoverTheme> discoverTheme;
  DiscoverThemeModel({
    required this.subCategoryName,
    required this.discoverTheme,
  });

  DiscoverThemeModel copyWith({
    String? subCategoryName,
    List<DiscoverTheme>? discoverTheme,
  }) {
    return DiscoverThemeModel(
      subCategoryName: subCategoryName ?? this.subCategoryName,
      discoverTheme: discoverTheme ?? this.discoverTheme,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subCategoryName': subCategoryName,
      'discoverTheme': discoverTheme.map((x) => x.toJson()).toList(),
    };
  }

  factory DiscoverThemeModel.fromMap(Map<String, dynamic> map) {
    return DiscoverThemeModel(
      subCategoryName: map['subcategoryName'] ?? '',
      discoverTheme: List<DiscoverTheme>.from(
          map['discoverData']?.map((x) => DiscoverTheme.fromJson(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory DiscoverThemeModel.fromJson(String source) =>
      DiscoverThemeModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DiscoverThemeModel &&
        other.subCategoryName == subCategoryName &&
        listEquals(other.discoverTheme, discoverTheme);
  }

  @override
  int get hashCode => subCategoryName.hashCode ^ discoverTheme.hashCode;
}
