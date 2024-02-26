import 'package:dartz/dartz.dart';
import 'package:snipit/features/onboarding/data/model/user_response_model.dart';
import 'package:snipit/features/onboarding/domain/entities/login_via_email_entity.dart';
import 'package:snipit/features/onboarding/domain/repositories/onboarding_repository.dart';

import '../../../../core/constants/usecase/usecase_interface.dart';
import '../../../../core/error/failure.dart';

class LoginViaEmailUsecase
    implements UseCase<UserResponseModel, EmailLoginEntity> {
  OnboardingRepository repository;

  LoginViaEmailUsecase({required this.repository});
  @override
  Future<Either<Failure, UserResponseModel>> call(EmailLoginEntity entity) {
    return repository.logInViaEmail(entity);
  }
}
