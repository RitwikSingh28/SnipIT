class CheckUserNameEntity{
  String username;
  CheckUserNameEntity({required this.username});

  Map<String,dynamic> toJson(){
    return {
      "username":username
    };
  }
}