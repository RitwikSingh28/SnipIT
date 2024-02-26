import 'package:dartz/dartz.dart';
import 'package:snipit/core/error/failure.dart';
import 'package:snipit/features/account/domain/entities/update_username_entity.dart';
import 'package:snipit/features/account/domain/repositories/account_repository.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';
import '../datasource/account_datasource.dart';
import '../models/update_user_name_response_model.dart';

class AccountRepositoryImpl extends AccountRepository{
  final NetworkInfo networkInfo;
  final AccountDataSource dataSource;
  AccountRepositoryImpl({required this.networkInfo,required this.dataSource});

  @override
  Future<Either<Failure, UpdateUserNameModel>> checkUserName(CheckUserNameEntity entity) async{
    if (await networkInfo.isConnected) {
      try {
        final response =
            await dataSource.checkUserName(entity); //response of type model
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure());
      } on ApiException catch (e) {
        return Left(ApiFailure(message: e.message));
      }
    } else {
      return Left(InternetFailure());
    }
  }
}