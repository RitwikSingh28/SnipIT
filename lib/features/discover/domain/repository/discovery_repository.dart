import 'package:dartz/dartz.dart';
import 'package:snipit/core/constants/usecase/usecase_interface.dart';
import 'package:snipit/features/discover/data/models/discover_response_model.dart';
import 'package:snipit/features/discover/data/models/get_my_discovery_themes.dart';
import 'package:snipit/features/feed/data/models/get_news_by_category_model.dart';
import 'package:snipit/features/feed/data/models/user_preference_model.dart';
import 'package:snipit/features/feed/data/models/user_preference_response.dart';
import '../../../../core/error/failure.dart';

abstract class DiscoveryRepository {
  Future<Either<Failure, GetMyDiscoveryThemesModelClass>>
      getMyDiscoveryThemes();
  Future<Either<Failure, DiscoverResponseModel>> getAllDiscoverThemes();
  Future<Either<Failure, PreferenceResponseModel>> updateMyDiscoverThemes(
      List<String> discoverThemes);
  Future<Either<Failure, NewsByCategoryResponse>> getDiscoverNews();
}
