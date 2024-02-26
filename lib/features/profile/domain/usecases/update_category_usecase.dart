import 'package:dartz/dartz.dart';
import 'package:snipit/core/constants/usecase/usecase_interface.dart';
import 'package:snipit/core/error/failure.dart';
import 'package:snipit/features/profile/data/model/update_category_model.dart';
import 'package:snipit/features/profile/domain/entity/update_category_entity.dart';

import 'package:snipit/features/profile/domain/repository/profile_repository.dart';

class UpdateCategoryUsecase
    extends UseCase<UpdateCategoryModel, UpdateCategoryEntity> {
  ProfileRepository repository;
  UpdateCategoryUsecase({required this.repository});
  @override
  Future<Either<Failure, UpdateCategoryModel>> call(
      UpdateCategoryEntity entity) async {
    return await repository.updateCategory(entity);
  }
}
