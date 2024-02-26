import 'dart:convert';

import 'package:flutter/foundation.dart';

class GetSubCategoryEntity {
  List<String> categoriIds;
  GetSubCategoryEntity({
    required this.categoriIds,
  });

  GetSubCategoryEntity copyWith({
    List<String>? categoriIds,
  }) {
    return GetSubCategoryEntity(
      categoriIds: categoriIds ?? this.categoriIds,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'categoriIds': categoriIds,
    };
  }

  factory GetSubCategoryEntity.fromMap(Map<String, dynamic> map) {
    return GetSubCategoryEntity(
      categoriIds: List<String>.from(map['categoriIds']),
    );
  }

  String toJson() => json.encode(toMap());

  factory GetSubCategoryEntity.fromJson(String source) =>
      GetSubCategoryEntity.fromMap(json.decode(source));

  @override
  String toString() => 'GetSubCategoryEntity(categoriIds: $categoriIds)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetSubCategoryEntity &&
        listEquals(other.categoriIds, categoriIds);
  }

  @override
  int get hashCode => categoriIds.hashCode;
}
