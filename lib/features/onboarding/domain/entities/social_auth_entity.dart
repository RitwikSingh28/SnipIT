import 'dart:convert';

class SocialAuthEntity {
  final String provider;
  final String provider_id;
  final List<String> categories;
  final List<String> subcategories;

  SocialAuthEntity(
      {required this.provider,
      required this.provider_id,
      required this.categories,
      required this.subcategories});
  String socialAutModelToJson(SocialAuthEntity data) =>
      json.encode(data.toJson());
  Map<String, dynamic> toJson() => {
        "provider": provider,
        "provider_id": provider_id,
        "categories": categories,
        "subcategories": subcategories,
      };
}
