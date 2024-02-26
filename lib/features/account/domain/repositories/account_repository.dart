import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../onboarding/data/model/verify_otp_response.dart';
import '../../data/models/update_user_name_response_model.dart';
import '../entities/update_username_entity.dart';

abstract class AccountRepository{
  Future<Either<Failure, UpdateUserNameModel>> checkUserName(CheckUserNameEntity entity);
}