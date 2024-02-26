class AddInteractionResponseModel {
  bool? success;
  String? message;
  InteractionModel? interactionModel;

  AddInteractionResponseModel({this.success, this.message, this.interactionModel});

  AddInteractionResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    interactionModel = json['data'] != null ? InteractionModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.interactionModel != null) {
      data['data'] = this.interactionModel!.toJson();
    }
    return data;
  }
}

class InteractionModel {
  String? sId;
  String? newsId;
  String? userId;
  String? createdAt;
  bool? isViewed;
  bool? seeLess;
  bool? seeMore;
  String? updatedAt;

  InteractionModel(
      {this.sId,
        this.newsId,
        this.userId,
        this.createdAt,
        this.isViewed,
        this.seeLess,
        this.seeMore,
        this.updatedAt});

  InteractionModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    newsId = json['newsId'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    isViewed = json['isViewed'];
    seeLess = json['seeLess'];
    seeMore = json['seeMore'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['newsId'] = this.newsId;
    data['userId'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['isViewed'] = this.isViewed;
    data['seeLess'] = this.seeLess;
    data['seeMore'] = this.seeMore;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}