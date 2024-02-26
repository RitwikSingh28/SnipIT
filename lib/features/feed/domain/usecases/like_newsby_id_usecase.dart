import 'package:dartz/dartz.dart';
import 'package:snipit/core/constants/usecase/usecase_interface.dart';
import 'package:snipit/core/error/failure.dart';
import 'package:snipit/features/feed/data/models/like_news_by_id_model.dart';
import 'package:snipit/features/feed/domain/repositories/feed-repository.dart';
import 'package:snipit/features/onboarding/domain/entities/like_newsby_id_entity.dart';

import '../../../onboarding/domain/repositories/onboarding_repository.dart';

class LikeNewsByIdUseCase
    extends UseCase<LikeNewsByIdModel, LikeNewsByIdEntity> {
  FeedRepository repository;
  LikeNewsByIdUseCase({required this.repository});
  @override
  Future<Either<Failure, LikeNewsByIdModel>> call(
      LikeNewsByIdEntity entity) async {
    return await repository.likeNewsById(entity);
  }
}
