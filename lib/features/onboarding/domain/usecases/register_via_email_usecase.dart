import 'package:dartz/dartz.dart';
import 'package:snipit/core/constants/usecase/usecase_interface.dart';
import 'package:snipit/core/error/failure.dart';
import 'package:snipit/features/onboarding/data/model/register_response_model.dart';
import 'package:snipit/features/onboarding/domain/entities/register-email-entity.dart';
import 'package:snipit/features/onboarding/domain/repositories/onboarding_repository.dart';

class RegisterViaEmailUseCase
    extends UseCase<RegisterResponseModel, RegisterEmailEntity> {
  final OnboardingRepository repository;
  RegisterViaEmailUseCase({required this.repository});

  @override
  Future<Either<Failure, RegisterResponseModel>> call(
      RegisterEmailEntity entity) {
    return repository.registerViaEmail(entity);
  }
}
