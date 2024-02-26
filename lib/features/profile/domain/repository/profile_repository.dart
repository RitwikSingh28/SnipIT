import 'package:dartz/dartz.dart';
import 'package:snipit/core/error/failure.dart';

import '../../data/model/update_category_model.dart';
import '../entity/update_category_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UpdateCategoryModel>> updateCategory(
      UpdateCategoryEntity entity);
}
