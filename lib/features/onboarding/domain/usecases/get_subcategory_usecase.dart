import 'package:dartz/dartz.dart';
import 'package:snipit/core/constants/usecase/usecase_interface.dart';
import 'package:snipit/core/error/failure.dart';
import 'package:snipit/features/onboarding/data/model/subcategory_response_model.dart';
import 'package:snipit/features/onboarding/domain/entities/get-subcategories-entity.dart';
import 'package:snipit/features/onboarding/domain/repositories/onboarding_repository.dart';

class GetSubcategoryUseCase
    extends UseCase<SubCategoryResponseModel, GetSubCategoryEntity> {
  OnboardingRepository repository;
  GetSubcategoryUseCase({required this.repository});
  @override
  Future<Either<Failure, SubCategoryResponseModel>> call(
      GetSubCategoryEntity entity) {
    return repository.getSubCategoriesBasedOnCategories(entity);
  }
}
