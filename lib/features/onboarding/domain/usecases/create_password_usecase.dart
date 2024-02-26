import 'package:dartz/dartz.dart';
import 'package:snipit/core/constants/usecase/usecase_interface.dart';
import 'package:snipit/core/error/failure.dart';
import 'package:snipit/features/onboarding/domain/entities/verify-otp-event.dart';
import 'package:snipit/features/onboarding/domain/repositories/onboarding_repository.dart';

import '../../data/model/create_password_response.dart';
import '../entities/change_password_entity.dart';
import '../entities/submit_email_entity.dart';

class CreatePasswordUseCase implements UseCase<CreatePasswordResponse,ChangePasswordEntity>{
  OnboardingRepository onboardingRepository;
  CreatePasswordUseCase({required this.onboardingRepository});
  @override
  Future<Either<Failure, CreatePasswordResponse>> call(ChangePasswordEntity entity) {
    return onboardingRepository.createPassword(entity);
  }
}