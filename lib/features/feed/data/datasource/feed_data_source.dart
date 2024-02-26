import 'dart:convert';
import 'dart:developer';

import 'package:snipit/core/api/base/custom_http_client.dart';
import 'package:snipit/core/constants/url_constant.dart';
import 'package:snipit/core/error/exception.dart';
import 'package:snipit/core/helpers/user_helpers.dart';
import 'package:snipit/features/feed/data/models/get_news_by_category_model.dart';
import 'package:snipit/features/feed/data/models/user_preference_response.dart';
import 'package:snipit/features/feed/domain/entity/get_newsby_category_entity.dart';
import 'package:snipit/features/feed/domain/entity/interaction_entity.dart';
import 'package:snipit/features/feed/domain/usecases/get_preference_usecase.dart';
import 'package:snipit/features/feed/data/models/like_news_by_id_model.dart';
import 'package:snipit/features/onboarding/domain/entities/like_newsby_id_entity.dart';
import 'package:snipit/features/profile/data/model/update_category_model.dart';
import 'package:snipit/features/profile/domain/entity/update_category_entity.dart';

import '../../domain/entity/get_my_news_entity.dart';
import '../models/add_interaction_response.dart';

abstract class FeedDataSource {
  Future<PreferenceResponseModel> getPreferences();
  Future<LikeNewsByIdModel> likeNewsById(LikeNewsByIdEntity entity);
  Future<NewsByCategoryResponse> getNewsByCategory(
      GetNewsByCategoryEntity entity);
  Future<NewsByCategoryResponse> getNewsByUser({required GetMyNewsEntity entity});
  Future<UpdateCategoryModel> updateCategory(UpdateCategoryEntity entity);
  Future<AddInteractionResponseModel> addInteraction(InteractionEntity entity);
}

class FeedDataSourceImpl extends FeedDataSource {
  CustomHttpClient customHttpClient = CustomHttpClient();
  @override
  Future<PreferenceResponseModel> getPreferences() async {
    final response = await customHttpClient.get(Uri.parse(getMyPreferencesUrl));
    log(response.body);
    if (response.statusCode == 200) {
      PreferenceResponseModel result =
          PreferenceResponseModel.fromMap(jsonDecode(response.body));
      if (result.status) {
        return result;
      } else {
        throw ApiException(message: result.message);
      }
    } else if (response.statusCode == 404 || response.statusCode == 400) {
      throw ApiException(message: json.decode(response.body)["message"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<NewsByCategoryResponse> getNewsByCategory(
      GetNewsByCategoryEntity entity) async {
    String url="$getNewsByCategoryUrl/${entity.category}?limit=${entity.limit}&skip=${entity.skip}";
    log(url);
    final response = await customHttpClient
        .get(Uri.parse(url));
    log(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data["success"]) {
        return NewsByCategoryResponse.fromJson(data);
      }
      return NewsByCategoryResponse.fromJson(data);
    } else if (response.statusCode == 404) {
      throw ApiException(message: json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<LikeNewsByIdModel> likeNewsById(LikeNewsByIdEntity entity) async {
    final response = await customHttpClient.post(
        Uri.parse(likeNewsIdUrl), jsonEncode(entity.toJson()));
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      return LikeNewsByIdModel.fromJson(result);
    } else if (response.statusCode == 404) {
      throw ApiException(message: json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<NewsByCategoryResponse> getNewsByUser({required GetMyNewsEntity entity}) async {
    String url="$getNewsByUserUrl?limit=${entity.limit}&skip=${entity.skip}";
    log(url);
    final response = await customHttpClient.get(Uri.parse(url));
    log("All News Response ${response.body}");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return NewsByCategoryResponse.fromJson(data);
    } else if (response.statusCode == 404) {
      throw ApiException(message: json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UpdateCategoryModel> updateCategory(
      UpdateCategoryEntity entity) async {
    final response = await customHttpClient.put(
        Uri.parse(updateCategoryUrl), jsonEncode(entity.toJson()));
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      var responseModel = UpdateCategoryModel.fromJson(result);
      UserHelpers.setPreferences(responseModel.preferences);
      return responseModel;
    } else if (response.statusCode == 404) {
      throw ApiException(message: json.decode(response.body)['message']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AddInteractionResponseModel> addInteraction(InteractionEntity entity) async{
    log("$interactionUrl/${entity.interactionType.value}");
    final response = await customHttpClient.post(
        Uri.parse("$interactionUrl/${entity.interactionType.value}"), jsonEncode(entity.newsIDEntity.toJson()));
    log("${response.statusCode}--->${response.body}");
    if (response.statusCode == 200 || response.statusCode==201) {
      var result = jsonDecode(response.body);
      var responseModel = AddInteractionResponseModel.fromJson(result);
      return responseModel;
    }
    else if (response.statusCode == 404) {
      throw ApiException(message: json.decode(response.body)['message']);
    }
    else {
      throw ServerException();
    }
  }
}
