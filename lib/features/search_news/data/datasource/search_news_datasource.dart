import 'dart:convert';
import 'dart:developer';
import 'package:snipit/core/api/base/custom_http_client.dart';
import 'package:snipit/core/constants/url_constant.dart';
import 'package:snipit/core/error/exception.dart';
import 'package:snipit/features/feed/data/models/get_news_by_category_model.dart';
import 'package:snipit/features/search_news/domain/entity/search_news_entity.dart';

import '../models/search_news_response_model.dart';


abstract class SearchNewsDataSource {
  Future<SearchNewsResponse> searchNews({required SearchNewsEntity entity});
}

class SearchNewsDataSourceImpl extends SearchNewsDataSource {
  CustomHttpClient customHttpClient = CustomHttpClient();


  @override
  Future<SearchNewsResponse> searchNews({required SearchNewsEntity entity}) async {
    String url="$searchNewsUrl?searchQuery=${entity.searchTerm}&skip=${entity.skip}&limit=${entity.limit}";
    log(url);
    final response = await customHttpClient.get(Uri.parse(url));
    log("All News Response ${response.body}");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return SearchNewsResponse.fromJson(data);
    } else if (response.statusCode == 404) {
      throw ApiException(message: json.decode(response.body));
    } else {
      throw ServerException();
    }
  }


}
