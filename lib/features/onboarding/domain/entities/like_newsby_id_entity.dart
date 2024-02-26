import 'dart:convert';

class LikeNewsByIdEntity {
  final String newsId;

  LikeNewsByIdEntity({required this.newsId});
  String likeNewsByIdToJson(LikeNewsByIdEntity data) =>
      json.encode(data.toJson());
  Map<String, dynamic> toJson() => {
        "newsId": newsId,
      };
}
