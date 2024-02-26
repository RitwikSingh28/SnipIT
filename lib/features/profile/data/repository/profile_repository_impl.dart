import 'package:dartz/dartz.dart';
import 'package:snipit/core/error/failure.dart';
import 'package:snipit/features/profile/data/data_source/profile_data_source_impl.dart';
import 'package:snipit/features/profile/data/model/update_category_model.dart';
import 'package:snipit/features/profile/domain/entity/update_category_entity.dart';
import 'package:snipit/features/profile/domain/repository/profile_repository.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileDataSource dataSource;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl({required this.dataSource, required this.networkInfo});
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
}
