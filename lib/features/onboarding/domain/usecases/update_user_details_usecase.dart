import 'package:dartz/dartz.dart';
import 'package:snipit/core/constants/usecase/usecase_interface.dart';
import 'package:snipit/core/error/failure.dart';
import 'package:snipit/features/onboarding/data/model/update_user_details_model.dart';
import 'package:snipit/features/onboarding/domain/entities/update_user_details_entity.dart';
import 'package:snipit/features/onboarding/domain/repositories/onboarding_repository.dart';

class UpdateUserDetailsUseCase
    extends UseCase<UpdateUserDetailsModel, UpdateUserDetailsEntity> {
  OnboardingRepository repository;

  UpdateUserDetailsUseCase({required this.repository});
  @override
  Future<Either<Failure, UpdateUserDetailsModel>> call(
      UpdateUserDetailsEntity entity) async {
    return await repository.updateUserDetails(entity);
  }
}
