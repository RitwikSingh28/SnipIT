import 'package:dartz/dartz.dart';
import 'package:snipit/core/constants/usecase/usecase_interface.dart';
import 'package:snipit/core/error/failure.dart';
import 'package:snipit/features/onboarding/data/model/category_model.dart';
//import 'package:snipit/features/onboarding/domain/entities/categories_entity.dart';
import 'package:snipit/features/onboarding/domain/repositories/onboarding_repository.dart';

class GetCategoryUseCase extends UseCase<List<CategoryModel>, NoParams> {
  final OnboardingRepository categoryRepository;
  GetCategoryUseCase({required this.categoryRepository});
  @override
  Future<Either<Failure, List<CategoryModel>>> call(NoParams noParams) {
    return categoryRepository.getAllCategories(noParams);
  }
}
