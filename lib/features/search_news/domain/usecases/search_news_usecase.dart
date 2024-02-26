import 'package:dartz/dartz.dart';
import 'package:snipit/core/constants/usecase/usecase_interface.dart';
import 'package:snipit/core/error/failure.dart';
import 'package:snipit/features/feed/data/models/get_news_by_category_model.dart';
import 'package:snipit/features/feed/domain/repositories/feed-repository.dart';
import 'package:snipit/features/search_news/domain/entity/search_news_entity.dart';
import 'package:snipit/features/search_news/domain/repositories/search_news_reporsitory.dart';

import '../../data/models/search_news_response_model.dart';

class SearchNewsUseCase extends UseCase<SearchNewsResponse, SearchNewsEntity> {
  final SearchNewsRepository repository;
  SearchNewsUseCase({required this.repository});
  @override
  Future<Either<Failure, SearchNewsResponse>> call(SearchNewsEntity entity) {
    return repository.searchNews(entity: entity);
  }
}
