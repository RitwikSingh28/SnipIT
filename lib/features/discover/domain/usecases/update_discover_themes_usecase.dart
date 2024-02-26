import 'package:dartz/dartz.dart';
import 'package:snipit/core/constants/usecase/usecase_interface.dart';
import 'package:snipit/core/error/failure.dart';
import 'package:snipit/features/discover/domain/repository/discovery_repository.dart';
import 'package:snipit/features/feed/data/models/user_preference_model.dart';
import 'package:snipit/features/feed/data/models/user_preference_response.dart';

class UpdateDiscoverThemesUsecase
    extends UseCase<PreferenceResponseModel, List<String>> {
  final DiscoveryRepository repository;
  UpdateDiscoverThemesUsecase({required this.repository});
  @override
  Future<Either<Failure, PreferenceResponseModel>> call(List<String> entity) {
    return repository.updateMyDiscoverThemes(entity);
  }
}
