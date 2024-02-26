import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import 'package:snipit/core/constants/usecase/usecase_interface.dart';
import 'package:snipit/core/error/failure.dart';
import 'package:snipit/features/feed/data/models/user_preference_response.dart';
import 'package:snipit/features/feed/domain/repositories/feed-repository.dart';
import 'package:snipit/features/onboarding/data/model/category_model.dart';
import 'package:snipit/features/onboarding/data/model/subcategory_model.dart';

class GetPreferenceUseCase extends UseCase<PreferenceResponseModel, NoParams> {
  final FeedRepository repository;
  GetPreferenceUseCase({required this.repository});
  @override
  Future<Either<Failure, PreferenceResponseModel>> call(NoParams entity) {
    return repository.getPreferences();
  }
}
