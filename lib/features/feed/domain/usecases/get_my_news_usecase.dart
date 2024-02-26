import 'package:dartz/dartz.dart';
import 'package:snipit/core/constants/usecase/usecase_interface.dart';
import 'package:snipit/core/error/failure.dart';
import 'package:snipit/features/feed/data/models/get_news_by_category_model.dart';
import 'package:snipit/features/feed/domain/repositories/feed-repository.dart';

import '../entity/get_my_news_entity.dart';

class GetMyNewsUseCase extends UseCase<NewsByCategoryResponse, GetMyNewsEntity> {
  final FeedRepository repository;
  GetMyNewsUseCase({required this.repository});
  @override
  Future<Either<Failure, NewsByCategoryResponse>> call(GetMyNewsEntity entity) {
    return repository.getNewsByUser(entity: entity);
  }
}
