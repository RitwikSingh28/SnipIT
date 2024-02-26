// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:snipit/core/constants/usecase/usecase_interface.dart';
import 'package:snipit/core/error/failure.dart';
import 'package:snipit/features/onboarding/data/model/social_auth_model.dart';
import 'package:snipit/features/onboarding/domain/entities/social_auth_entity.dart';
import 'package:snipit/features/onboarding/domain/repositories/onboarding_repository.dart';

class SocialAuthUseCase extends UseCase<SocialAuthModel, SocialAuthEntity> {
  OnboardingRepository repository;
  SocialAuthUseCase({
    required this.repository,
  });
  @override
  Future<Either<Failure, SocialAuthModel>> call(SocialAuthEntity entity) async {
    return await repository.socialAuth(entity);
  }
}
