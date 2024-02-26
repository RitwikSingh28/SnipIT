import 'package:dartz/dartz.dart';
import 'package:snipit/core/constants/usecase/usecase_interface.dart';
import 'package:snipit/core/error/failure.dart';
import 'package:snipit/features/account/domain/repositories/account_repository.dart';


import '../../data/models/update_user_name_response_model.dart';
import '../entities/update_username_entity.dart';

class CheckUserNameUseCase extends UseCase<UpdateUserNameModel,CheckUserNameEntity> {
  final AccountRepository repository;
  CheckUserNameUseCase({required this.repository});

  @override
  Future<Either<Failure, UpdateUserNameModel>> call(CheckUserNameEntity entity) {
    return repository.checkUserName(entity);
  }
}
