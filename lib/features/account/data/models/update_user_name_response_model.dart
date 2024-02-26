class UpdateUserNameModel {
  bool? success;
  String? message;
  UpdateUserName? updateUserName;

  UpdateUserNameModel({this.success, this.message, this.updateUserName});

  UpdateUserNameModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    updateUserName = json['data'] != null ? UpdateUserName.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.updateUserName != null) {
      data['data'] = this.updateUserName!.toJson();
    }
    return data;
  }
}

class UpdateUserName {
  bool? isAvailable;
  String? username;

  UpdateUserName({this.isAvailable, this.username});

  UpdateUserName.fromJson(Map<String, dynamic> json) {
    isAvailable = json['isAvailable'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isAvailable'] = this.isAvailable;
    data['username'] = this.username;
    return data;
  }
}