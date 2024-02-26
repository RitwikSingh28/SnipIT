import 'dart:convert';

String submitEmailEntityToJson(SubmitEmailEntity entity)=>jsonEncode(entity.toJson());

class SubmitEmailEntity {
  String email;
  SubmitEmailEntity({
    required this.email,
  });

Map<String,dynamic> toJson(){
  return {
    "email":email
  };
}

}
