import 'package:dartz/dartz.dart';
import 'package:snipit/core/constants/usecase/usecase_interface.dart';
import 'package:snipit/core/error/failure.dart';
import 'package:snipit/features/discover/domain/repository/discovery_repository.dart';
import 'package:snipit/features/feed/data/models/get_news_by_category_model.dart';

class GetDiscoverNewsUseCase extends UseCase<NewsByCategoryResponse, NoParams> {
  final DiscoveryRepository repository;
  GetDiscoverNewsUseCase({required this.repository});
  @override
  Future<Either<Failure, NewsByCategoryResponse>> call(NoParams entity) {
    return repository.getDiscoverNews();
  }
}
