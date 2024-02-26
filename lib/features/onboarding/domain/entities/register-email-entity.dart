import 'dart:convert';

import 'package:flutter/foundation.dart';

class RegisterEmailEntity {
  String email;
  String password;
  List<String> categories;
  List<String> subcategories;
  RegisterEmailEntity({
    required this.email,
    required this.password,
    required this.categories,
    required this.subcategories,
  });

  RegisterEmailEntity copyWith({
    String? email,
    String? password,
    List<String>? categories,
    List<String>? subcategories,
  }) {
    return RegisterEmailEntity(
      email: email ?? this.email,
      password: password ?? this.password,
      categories: categories ?? this.categories,
      subcategories: subcategories ?? this.subcategories,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'categories': categories,
      'subcategories': subcategories,
    };
  }

  factory RegisterEmailEntity.fromMap(Map<String, dynamic> map) {
    return RegisterEmailEntity(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      categories: List<String>.from(map['categories']),
      subcategories: List<String>.from(map['subcategories']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterEmailEntity.fromJson(String source) =>
      RegisterEmailEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RegisterEmailEntity(email: $email, password: $password, categories: $categories, subcategories: $subcategories)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegisterEmailEntity &&
        other.email == email &&
        other.password == password &&
        listEquals(other.categories, categories) &&
        listEquals(other.subcategories, subcategories);
  }

  @override
  int get hashCode {
    return email.hashCode ^
        password.hashCode ^
        categories.hashCode ^
        subcategories.hashCode;
  }
}
