import 'package:dartz/dartz.dart';
import 'package:snipit/core/constants/usecase/usecase_interface.dart';
import 'package:snipit/core/error/failure.dart';
import 'package:snipit/features/onboarding/data/model/verify_otp_response.dart';
import 'package:snipit/features/onboarding/domain/entities/verify-otp-event.dart';
import 'package:snipit/features/onboarding/domain/repositories/onboarding_repository.dart';

import '../entities/submit_email_entity.dart';

class CheckOtpUseCase implements UseCase<VerifyOtpResponse,VerifyOtpEntity>{
  OnboardingRepository onboardingRepository;
  CheckOtpUseCase({required this.onboardingRepository});
  @override
  Future<Either<Failure, VerifyOtpResponse>> call(VerifyOtpEntity entity) {
    return onboardingRepository.checkOtp(entity);
  }
}