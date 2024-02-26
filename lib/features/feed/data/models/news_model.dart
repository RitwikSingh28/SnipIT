import 'package:snipit/features/onboarding/data/model/category_model.dart';
import 'package:snipit/features/onboarding/data/model/subcategory_model.dart';

class News {
  String id;
  NewsMetaModel? newsMeta;
  String title;
  String image;
  int likesCount;
  bool liked;
  List<String> tags;
  String body;
  CategoryModel? categoryId;
  SubcategoryModel? subCategoryId;
  DateTime updatedAt;

  News({
    required this.id,
    this.newsMeta,
    required this.title,
    required this.image,
    required this.likesCount,
    required this.tags,
    required this.liked,
    required this.body,
    this.categoryId,
    required this.subCategoryId,
    required this.updatedAt,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
      id: json["_id"],
      newsMeta: json["newsMeta"]==null?null:NewsMetaModel.fromJson(json["newsMeta"]),
      title: json["title"],
      image: json["image"],
      likesCount: json["likesCount"],
      tags: [], // List<String>.from(json["tags"].map((x) => x)),
      body: json["body"] ?? "",
      categoryId: json ["categoryId"]!=null?CategoryModel.fromMap(json ["categoryId"]):null,
      subCategoryId: json["subCategoryId"] != null
          ? SubcategoryModel.fromMap(json["subCategoryId"])
          : null,
      updatedAt: DateTime.parse(json["updatedAt"]),
      liked: json['liked'] ?? false);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "image": image,
        "likesCount": likesCount,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "body": body,
        "categoryId": categoryId,
        "subCategoryId": subCategoryId,
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class NewsMetaModel{
  String? newsSource;
  DateTime? postedTime;
  String? articleId;
  List<dynamic>? keywords;
  NewsMetaModel({this.newsSource,this.postedTime,this.articleId,this.keywords});

  factory NewsMetaModel.fromJson(Map<String,dynamic> json){
    return NewsMetaModel(newsSource: json["newsSource"],
          postedTime: json["postedTime"]==null?null:DateTime.parse(json["postedTime"]),
          articleId:json["article_id"],
          keywords: json["keywords"]==null?null:json["keywords"]
    );
  }

}
