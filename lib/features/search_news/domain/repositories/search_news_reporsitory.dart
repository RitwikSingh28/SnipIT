import 'package:dartz/dartz.dart';
import 'package:snipit/core/error/failure.dart';
import 'package:snipit/features/feed/data/models/get_news_by_category_model.dart';
import 'package:snipit/features/search_news/domain/entity/search_news_entity.dart';

import '../../data/models/search_news_response_model.dart';

abstract class SearchNewsRepository {
  Future<Either<Failure, SearchNewsResponse>> searchNews({required SearchNewsEntity entity});
}
