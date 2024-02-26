import 'package:dartz/dartz.dart';
import 'package:snipit/core/error/failure.dart';
import 'package:snipit/features/feed/data/models/get_news_by_category_model.dart';
import 'package:snipit/features/feed/data/models/like_news_by_id_model.dart';
import 'package:snipit/features/feed/data/models/user_preference_response.dart';
import 'package:snipit/features/feed/domain/entity/get_newsby_category_entity.dart';
import 'package:snipit/features/feed/domain/entity/interaction_entity.dart';
import 'package:snipit/features/feed/domain/usecases/get_preference_usecase.dart';
import 'package:snipit/features/onboarding/domain/entities/like_newsby_id_entity.dart';
import 'package:snipit/features/profile/data/model/update_category_model.dart';
import 'package:snipit/features/profile/domain/entity/update_category_entity.dart';

import '../../data/models/add_interaction_response.dart';
import '../entity/get_my_news_entity.dart';

abstract class FeedRepository {
  Future<Either<Failure, PreferenceResponseModel>> getPreferences();
  Future<Either<Failure, NewsByCategoryResponse>> getNewsByCategory(
      GetNewsByCategoryEntity entity);
  Future<Either<Failure, LikeNewsByIdModel>> likeNewsById(
      LikeNewsByIdEntity entity);
  Future<Either<Failure, NewsByCategoryResponse>> getNewsByUser({required GetMyNewsEntity entity});
  Future<Either<Failure, UpdateCategoryModel>> updateCategory(
      UpdateCategoryEntity entity);
  Future<Either<Failure, AddInteractionResponseModel>> addInteraction(
      InteractionEntity entity);
}
