import 'package:dartz/dartz.dart';
import 'package:snipit/core/constants/usecase/usecase_interface.dart';
import 'package:snipit/core/error/failure.dart';
import 'package:snipit/features/onboarding/data/model/verify_email_response.dart';
import 'package:snipit/features/onboarding/domain/repositories/onboarding_repository.dart';

import '../entities/submit_email_entity.dart';

class CheckEmailUseCase implements UseCase<VerifyEmailResponse,SubmitEmailEntity>{
  OnboardingRepository onboardingRepository;
  CheckEmailUseCase({required this.onboardingRepository});
  @override
  Future<Either<Failure, VerifyEmailResponse>> call(SubmitEmailEntity entity) {
    return onboardingRepository.checkEmail(entity);
  }
}