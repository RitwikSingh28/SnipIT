import 'package:dartz/dartz.dart';
import 'package:snipit/core/constants/usecase/usecase_interface.dart';
import 'package:snipit/core/error/failure.dart';
import 'package:snipit/features/discover/data/models/get_my_discovery_themes.dart';
import 'package:snipit/features/discover/domain/repository/discovery_repository.dart';

class GetMyDiscoveryThemesUseCase
    extends UseCase<GetMyDiscoveryThemesModelClass, NoParams> {
  DiscoveryRepository repository;
  GetMyDiscoveryThemesUseCase({required this.repository});
  @override
  Future<Either<Failure, GetMyDiscoveryThemesModelClass>> call(
      NoParams entity) async {
    return await repository.getMyDiscoveryThemes();
  }
}
