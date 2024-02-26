import 'package:dartz/dartz.dart';
import 'package:snipit/core/error/exception.dart';
import 'package:snipit/core/error/failure.dart';
import 'package:snipit/core/network/network_info.dart';
import 'package:snipit/features/feed/data/models/get_news_by_category_model.dart';
import 'package:snipit/features/search_news/data/datasource/search_news_datasource.dart';
import 'package:snipit/features/search_news/domain/entity/search_news_entity.dart';
import 'package:snipit/features/search_news/domain/repositories/search_news_reporsitory.dart';

import '../models/search_news_response_model.dart';

class SearchNewsRepositoryImpl extends SearchNewsRepository {
  final SearchNewsDataSource dataSource;
  final NetworkInfo networkInfo;
  SearchNewsRepositoryImpl({required this.dataSource, required this.networkInfo});


  @override
  Future<Either<Failure, SearchNewsResponse>> searchNews({required SearchNewsEntity entity}) async {
    if (await networkInfo.isConnected) {
      try {
        final responce = await dataSource.searchNews(entity: entity);
        return right(responce);
      } on ServerException {
        return left(const ServerFailure());
      }
    } else {
      return left(const ServerFailure());
    }
  }
}
