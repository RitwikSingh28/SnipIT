import 'package:dartz/dartz.dart';
import 'package:snipit/core/error/exception.dart';
import 'package:snipit/core/error/failure.dart';
import 'package:snipit/core/network/network_info.dart';
import 'package:snipit/features/feed/data/datasource/feed_data_source.dart';
import 'package:snipit/features/feed/data/models/add_interaction_response.dart';
import 'package:snipit/features/feed/data/models/get_news_by_category_model.dart';
import 'package:snipit/features/feed/data/models/like_news_by_id_model.dart';

import 'package:snipit/features/feed/data/models/user_preference_response.dart';

import 'package:snipit/features/feed/domain/entity/get_newsby_category_entity.dart';
import 'package:snipit/features/feed/domain/entity/interaction_entity.dart';
import 'package:snipit/features/feed/domain/repositories/feed-repository.dart';
import 'package:snipit/features/feed/domain/usecases/get_preference_usecase.dart';
import 'package:snipit/features/onboarding/domain/entities/like_newsby_id_entity.dart';
import 'package:snipit/features/profile/data/model/update_category_model.dart';
import 'package:snipit/features/profile/domain/entity/update_category_entity.dart';

import '../../../domain/entity/get_my_news_entity.dart';

class FeedRepositoryImpl extends FeedRepository {
  final FeedDataSource dataSource;
  final NetworkInfo networkInfo;
  FeedRepositoryImpl({required this.dataSource, required this.networkInfo});

  @override
  Future<Either<Failure, PreferenceResponseModel>> getPreferences() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await dataSource.getPreferences();
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure());
      } on ApiException catch (e) {
        return Left(ApiFailure(message: e.message));
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, NewsByCategoryResponse>> getNewsByCategory(
      GetNewsByCategoryEntity entity) async {
    if (await networkInfo.isConnected) {
      try {
        final responce = await dataSource.getNewsByCategory(entity);
        return right(responce);
      } on ServerException {
        return left(const ServerFailure());
      }
    } else {
      return left(const ServerFailure());
    }
  }

  @override
  Future<Either<Failure, LikeNewsByIdModel>> likeNewsById(
      LikeNewsByIdEntity entity) async {
    if (await networkInfo.isConnected) {
      try {
        final responce = await dataSource.likeNewsById(entity);
        return right(responce);
      } on ServerException {
        return left(const ServerFailure());
      }
    } else {
      return left(const ServerFailure());
    }
  }

  @override
  Future<Either<Failure, NewsByCategoryResponse>> getNewsByUser({required GetMyNewsEntity entity}) async {
    if (await networkInfo.isConnected) {
      try {
        final responce = await dataSource.getNewsByUser(entity: entity);
        return right(responce);
      } on ServerException {
        return left(const ServerFailure());
      }
    } else {
      return left(const ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UpdateCategoryModel>> updateCategory(
      UpdateCategoryEntity entity) async {
    if (await networkInfo.isConnected) {
      try {
        final responce = await dataSource.updateCategory(entity);
        return right(responce);
      } on ServerException {
        return left(const ServerFailure());
      }
    } else {
      return left(const ServerFailure());
    }
  }

  @override
  Future<Either<Failure, AddInteractionResponseModel>> addInteraction(InteractionEntity entity) async{
    if (await networkInfo.isConnected) {
      try {
        final responce = await dataSource.addInteraction(entity);
        return right(responce);
      } on ServerException {
        return left(const ServerFailure());
      }
    } else {
      return left(const ServerFailure());
    }
  }
}
