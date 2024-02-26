import 'dart:convert';

class CreatePasswordResponse {
  String message;
  bool status;
  CreatePasswordResponse(
      {required this.message,required this.status});

  Map<String, dynamic> toMap() {
    return {'message': message,};
  }

  factory CreatePasswordResponse.fromMap(Map<String, dynamic> map) {
    return CreatePasswordResponse(
        message: map['message'] ?? '',
        status: map['success'] ?? false);
  }

  String toJson() => json.encode(toMap());

  factory CreatePasswordResponse.fromJson(String source) =>
      CreatePasswordResponse.fromMap(json.decode(source));

}
