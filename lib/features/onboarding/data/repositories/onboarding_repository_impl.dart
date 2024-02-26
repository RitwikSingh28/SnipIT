import 'package:dartz/dartz.dart';
import 'package:snipit/core/constants/usecase/usecase_interface.dart';
import 'package:snipit/core/error/exception.dart';
import 'package:snipit/core/error/failure.dart';
import 'package:snipit/core/network/network_info.dart';
import 'package:snipit/features/onboarding/data/datasource/onboarding_data_source.dart';
import 'package:snipit/features/onboarding/data/model/category_model.dart';
import 'package:snipit/features/onboarding/data/model/register_response_model.dart';
import 'package:snipit/features/onboarding/data/model/social_auth_model.dart';
import 'package:snipit/features/onboarding/data/model/subcategory_response_model.dart';
import 'package:snipit/features/onboarding/data/model/update_user_details_model.dart';
import 'package:snipit/features/onboarding/data/model/user_response_model.dart';
import 'package:snipit/features/onboarding/data/model/verify_email_response.dart';
import 'package:snipit/features/onboarding/data/model/verify_otp_response.dart';
import 'package:snipit/features/onboarding/domain/entities/change_password_entity.dart';
import 'package:snipit/features/onboarding/domain/entities/get-subcategories-entity.dart';
import 'package:snipit/features/onboarding/domain/entities/login_via_email_entity.dart';
import 'package:snipit/features/onboarding/domain/entities/register-email-entity.dart';
import 'package:snipit/features/onboarding/domain/entities/social_auth_entity.dart';
import 'package:snipit/features/onboarding/domain/entities/submit_email_entity.dart';
import 'package:snipit/features/onboarding/domain/entities/update_user_details_entity.dart';
import 'package:snipit/features/onboarding/domain/entities/verify-otp-event.dart';
import 'package:snipit/features/onboarding/domain/repositories/onboarding_repository.dart';

import '../model/create_password_response.dart';

class OnboardingRepositoryImpl extends OnboardingRepository {
  final OnBoardingDataSource dataSource;
  final NetworkInfo networkInfo;
  OnboardingRepositoryImpl({
    required this.dataSource,
    required this.networkInfo,
  });
  List<Map<String, dynamic>> categData = [];
  @override
  Future<Either<Failure, List<CategoryModel>>> getAllCategories(
      NoParams noParams) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await dataSource
            .getAllCategories(noParams); //response of type model
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure());
      } on ApiException catch (e) {
        return Left(ApiFailure(message: e.message));
      }
    } else {
      return Left(InternetFailure());
    }

    //throw UnimplementedError();
  }

  @override
  Future<Either<Failure, SubCategoryResponseModel>>
      getSubCategoriesBasedOnCategories(GetSubCategoryEntity entity) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await dataSource
            .getSubCategoriesBasedOnCategories(entity); //response of type model
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

  @override
  Future<Either<Failure, RegisterResponseModel>> registerViaEmail(
      RegisterEmailEntity entity) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await dataSource.registerViaEmail(entity); //response of type model
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

  @override
  Future<Either<Failure, VerifyOtpResponse>> verifyOtp(
      VerifyOtpEntity entity) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await dataSource.verifyOtp(entity); //response of type model
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

  @override
  Future<Either<Failure, UserResponseModel>> logInViaEmail(
      EmailLoginEntity entity) async {
    if (await networkInfo.isConnected) {
      try {
        final responce = await dataSource.logInViaEmail(entity);
        return right(responce);
      } on ServerException {
        return left(const ServerFailure());
      }
    } else {
      return left(const ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UpdateUserDetailsModel>> updateUserDetails(
      UpdateUserDetailsEntity entity) async {
    if (await networkInfo.isConnected) {
      try {
        final responce = await dataSource.updateUserDetails(entity);
        return right(responce);
      } on ServerException {
        return left(const ServerFailure());
      }
    } else {
      return left(const ServerFailure());
    }
  }

  @override
  Future<Either<Failure, SocialAuthModel>> socialAuth(
      SocialAuthEntity entity) async {
    if (await networkInfo.isConnected) {
      try {
        final responce = await dataSource.socialAuth(entity);
        return right(responce);
      } on ServerException {
        return left(const ServerFailure());
      }
    }
    else {
      return left(const ServerFailure());
    }
  }

  @override
  Future<Either<Failure, VerifyEmailResponse>> checkEmail(SubmitEmailEntity entity) async{
    if(await networkInfo.isConnected){
      try{
        final response=await dataSource.checkEmail(entity);
        return right(response);
      }
      on ServerException{
        return left(const ServerFailure());
      }

    }
    else{
      return left(const ServerFailure());
    }
  }

  @override
  Future<Either<Failure, VerifyOtpResponse>> checkOtp(VerifyOtpEntity entity) async{
    if(await networkInfo.isConnected){
      try{
        final response=await dataSource.checkOtp(entity);
        return right(response);
      }
      on ServerException{
        return left(const ServerFailure());
      }

    }
    else{
      return left(const ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CreatePasswordResponse>> createPassword(ChangePasswordEntity entity) async{
    if(await networkInfo.isConnected){
      try{
        final response=await dataSource.createPassword(entity);
        return right(response);
      }
      on ServerException{
        return left(const ServerFailure());
      }

    }
    else{
      return left(const ServerFailure());
    }
  }
}
