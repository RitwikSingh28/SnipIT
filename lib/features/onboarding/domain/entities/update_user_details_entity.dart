import 'dart:convert';

class UpdateUserDetailsEntity {
  final String? firstName;
  final String? lastName;
  final String? userName;
  final String? phone;
  final String? email;
  final String? photo;

  String updateUserDetailsModelToJson(UpdateUserDetailsEntity data) =>
      json.encode(data.toJson());

  const UpdateUserDetailsEntity(
      {this.firstName, this.lastName, this.phone,this.email,this.photo,this.userName});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonMap = {};

    if (firstName != null) jsonMap["firstName"] = firstName;
    if (lastName != null) jsonMap["lastName"] = lastName;
    if (userName != null) jsonMap["username"] = userName;
    if (phone != null) jsonMap["phone"] = phone;
    if (email != null) jsonMap["email"] = email;
    if (photo != null) jsonMap["profilePicture"] = photo;

    return jsonMap;
  }
}
