import 'dart:convert';
import 'dart:developer';

import 'package:snipit/core/constants/url_constant.dart';
import 'package:snipit/features/account/domain/entities/update_username_entity.dart';

import '../../../../core/api/base/custom_http_client.dart';
import '../../../../core/error/exception.dart';
import '../models/update_user_name_response_model.dart';

abstract class AccountDataSource{
  Future<UpdateUserNameModel> checkUserName(CheckUserNameEntity entity);
}

class AccountDataSourceImpl extends AccountDataSource{

  CustomHttpClient customHttpClient = CustomHttpClient();

  @override
  Future<UpdateUserNameModel> checkUserName(CheckUserNameEntity entity) async {
    log(updateUserNameUrl);
    final response =
    await customHttpClient.post(Uri.parse(updateUserNameUrl), jsonEncode(entity.toJson()));
    log(response.body);
    if (response.statusCode == 200) {
      return UpdateUserNameModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404 || response.statusCode == 400 || response.statusCode==402) {
      throw ApiException(message: json.decode(response.body)["message"]);
    } else {
      throw ServerException();
    }
  }


}