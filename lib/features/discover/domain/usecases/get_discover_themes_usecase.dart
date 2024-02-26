import 'package:dartz/dartz.dart';
import 'package:snipit/core/constants/usecase/usecase_interface.dart';
import 'package:snipit/core/error/failure.dart';
import 'package:snipit/features/discover/data/models/discover_response_model.dart';
import 'package:snipit/features/discover/domain/repository/discovery_repository.dart';

class GetDiscoverThemesUseCase
    extends UseCase<DiscoverResponseModel, NoParams> {
  final DiscoveryRepository repository;
  GetDiscoverThemesUseCase({required this.repository});
  @override
  Future<Either<Failure, DiscoverResponseModel>> call(NoParams entity) {
    return repository.getAllDiscoverThemes();
  }
}
