import 'package:dartz/dartz.dart';
import 'package:snipit/core/constants/usecase/usecase_interface.dart';
import 'package:snipit/core/error/failure.dart';
import 'package:snipit/features/discover/data/datasource/discovery_data_source.dart';
import 'package:snipit/features/discover/data/models/discover_response_model.dart';
import 'package:snipit/features/discover/data/models/get_my_discovery_themes.dart';
import 'package:snipit/features/discover/domain/repository/discovery_repository.dart';
import 'package:snipit/features/feed/data/models/get_news_by_category_model.dart';
import 'package:snipit/features/feed/data/models/user_preference_model.dart';
import 'package:snipit/features/feed/data/models/user_preference_response.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';

class DiscoveryRepositoryimpl extends DiscoveryRepository {
  final DiscoveryDataSource dataSource;
  final NetworkInfo networkInfo;

  DiscoveryRepositoryimpl(
      {required this.dataSource, required this.networkInfo});
  @override
  Future<Either<Failure, GetMyDiscoveryThemesModelClass>>
      getMyDiscoveryThemes() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await dataSource.getMyDiscoveryThemes();
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
  Future<Either<Failure, DiscoverResponseModel>> getAllDiscoverThemes() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await dataSource.getAllDiscoverThemes();
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
  Future<Either<Failure, PreferenceResponseModel>> updateMyDiscoverThemes(
      List<String> discoverThemes) async {
    try {
      final response = await dataSource.updateDiscoverThemes(discoverThemes);
      return Right(response);
    } on ServerException {
      return const Left(ServerFailure());
    } on ApiException catch (e) {
      return Left(ApiFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, NewsByCategoryResponse>> getDiscoverNews() async {
    try {
      final response = await dataSource.getDiscoveryNews();
      return Right(response);
    } on ServerException {
      return const Left(ServerFailure());
    } on ApiException catch (e) {
      return Left(ApiFailure(message: e.message));
    }
  }
}
