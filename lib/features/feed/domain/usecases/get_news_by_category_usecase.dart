import 'package:dartz/dartz.dart';
import 'package:snipit/core/constants/usecase/usecase_interface.dart';
import 'package:snipit/core/error/failure.dart';
import 'package:snipit/features/feed/data/models/get_news_by_category_model.dart';
import 'package:snipit/features/feed/domain/entity/get_newsby_category_entity.dart';
import 'package:snipit/features/feed/domain/repositories/feed-repository.dart';
import 'package:snipit/features/onboarding/domain/repositories/onboarding_repository.dart';

class GetNewsByCategoryUseCase
    extends UseCase<NewsByCategoryResponse, GetNewsByCategoryEntity> {
  FeedRepository repository;
  GetNewsByCategoryUseCase({required this.repository});
  @override
  Future<Either<Failure, NewsByCategoryResponse>> call(
      GetNewsByCategoryEntity entity) async {
    return await repository.getNewsByCategory(entity);
  }
}
