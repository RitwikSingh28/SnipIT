import 'dart:convert';

import 'package:snipit/core/constants/url_constant.dart';
import 'package:snipit/core/constants/usecase/usecase_interface.dart';
import 'package:snipit/core/helpers/ui_helpers.dart';
import 'package:snipit/core/helpers/user_helpers.dart';
import 'package:snipit/features/discover/data/models/discover_response_model.dart';
import 'package:snipit/features/discover/data/models/get_my_discovery_themes.dart';
import 'package:snipit/features/feed/data/models/get_news_by_category_model.dart';
import 'package:snipit/features/feed/data/models/user_preference_model.dart';
import 'package:snipit/features/feed/data/models/user_preference_response.dart';

import '../../../../core/api/base/custom_http_client.dart';
import '../../../../core/error/exception.dart';

abstract class DiscoveryDataSource {
  Future<GetMyDiscoveryThemesModelClass> getMyDiscoveryThemes();
  Future<DiscoverResponseModel> getAllDiscoverThemes();
  Future<PreferenceResponseModel> updateDiscoverThemes(List<String> entity);
  Future<NewsByCategoryResponse> getDiscoveryNews();
}

class DiscoveryDataSourceImpl extends DiscoveryDataSource {
  CustomHttpClient customHttpClient = CustomHttpClient();
  @override
  Future<GetMyDiscoveryThemesModelClass> getMyDiscoveryThemes() async {
    final response =
        await customHttpClient.get(Uri.parse(getmydiscoverythemesUrl));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data["success"]) {
        return GetMyDiscoveryThemesModelClass.fromJson(data);
      }
      return GetMyDiscoveryThemesModelClass.fromJson(data);
    } else if (response.statusCode == 404) {
      throw ApiException(message: json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  Future<DiscoverResponseModel> getAllDiscoverThemes() async {
    final response =
        await customHttpClient.get(Uri.parse(getAllDiscoverThemesUrl));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data["success"]) {
        return DiscoverResponseModel.fromMap(data);
      }
      return DiscoverResponseModel.fromJson(data);
    } else if (response.statusCode == 404) {
      throw ApiException(message: json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PreferenceResponseModel> updateDiscoverThemes(
      List<String> entity) async {
    final response = await customHttpClient.put(
        Uri.parse(updateDiscoverThemesUrl),
        jsonEncode({"discoveries": entity}));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data["success"]) {
        return PreferenceResponseModel.fromMap(data);
      } else {
        throw ApiException(message: "Failure");
      }
    } else if (response.statusCode == 404) {
      throw ApiException(message: json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<NewsByCategoryResponse> getDiscoveryNews() async {
    final response = await customHttpClient.get(Uri.parse(getDiscoverNewsUrl));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data["success"]) {
        return NewsByCategoryResponse.fromJson(data);
      } else {
        throw ApiException(message: "Failure");
      }
    } else if (response.statusCode == 404) {
      throw ApiException(message: json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
