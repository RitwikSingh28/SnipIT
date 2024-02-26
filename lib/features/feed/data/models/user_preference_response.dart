import 'dart:convert';

import 'package:snipit/features/feed/data/models/user_preference_model.dart';
import 'package:snipit/features/feed/domain/usecases/get_preference_usecase.dart';

class PreferenceResponseModel {
  bool status;
  String message;
  UserPreferenceModel preference;
  PreferenceResponseModel({
    required this.status,
    required this.message,
    required this.preference,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'preference': preference.toMap(),
    };
  }

  factory PreferenceResponseModel.fromMap(Map<String, dynamic> map) {
    return PreferenceResponseModel(
      status: map['success'] ?? false,
      message: map['message'] ?? '',
      preference: UserPreferenceModel.fromMap(map['userPrefDoc']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PreferenceResponseModel.fromJson(String source) =>
      PreferenceResponseModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'PreferenceResponseModel(status: $status, message: $message, preference: $preference)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PreferenceResponseModel &&
        other.status == status &&
        other.message == message &&
        other.preference == preference;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ preference.hashCode;
}
