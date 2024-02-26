import 'dart:convert';

import '../../../../core/api/base/custom_http_client.dart';
import '../../../../core/constants/url_constant.dart';
import '../../../../core/error/exception.dart';
import '../model/update_category_model.dart';
import '../../domain/entity/update_category_entity.dart';

abstract class ProfileDataSource {
  Future<UpdateCategoryModel> updateCategory(UpdateCategoryEntity entity);
}

class ProfileDataSourceImpl extends ProfileDataSource {
  CustomHttpClient customHttpClient = CustomHttpClient();

  @override
  Future<UpdateCategoryModel> updateCategory(
      UpdateCategoryEntity entity) async {
    final response = await customHttpClient.put(
        Uri.parse(updateCategoryUrl), jsonEncode(entity.toJson()));
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      return UpdateCategoryModel.fromJson(result);
    } else if (response.statusCode == 404) {
      throw ApiException(message: json.decode(response.body)['message']);
    } else {
      throw ServerException();
    }
  }
}
