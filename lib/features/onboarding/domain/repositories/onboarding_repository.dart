import 'package:dartz/dartz.dart';
import 'package:snipit/core/constants/usecase/usecase_interface.dart';
import 'package:snipit/features/onboarding/data/model/category_model.dart';
import 'package:snipit/features/feed/data/models/get_news_by_category_model.dart';
import 'package:snipit/features/feed/data/models/like_news_by_id_model.dart';
import 'package:snipit/features/onboarding/data/model/register_response_model.dart';
import 'package:snipit/features/onboarding/data/model/social_auth_model.dart';
import 'package:snipit/features/onboarding/data/model/subcategory_response_model.dart';
import 'package:snipit/features/onboarding/data/model/update_user_details_model.dart';
import 'package:snipit/features/onboarding/data/model/user_response_model.dart';
import 'package:snipit/features/onboarding/data/model/verify_email_response.dart';
import 'package:snipit/features/onboarding/data/model/verify_otp_response.dart';
import 'package:snipit/features/onboarding/domain/entities/change_password_entity.dart';

import 'package:snipit/features/onboarding/domain/entities/get-subcategories-entity.dart';
import 'package:snipit/features/feed/domain/entity/get_newsby_category_entity.dart';
import 'package:snipit/features/onboarding/domain/entities/like_newsby_id_entity.dart';
import 'package:snipit/features/onboarding/domain/entities/register-email-entity.dart';
import 'package:snipit/features/onboarding/domain/entities/social_auth_entity.dart';
import 'package:snipit/features/onboarding/domain/entities/submit_email_entity.dart';
import 'package:snipit/features/onboarding/domain/entities/update_user_details_entity.dart';
import 'package:snipit/features/onboarding/domain/entities/verify-otp-event.dart';
import 'package:snipit/features/onboarding/presentation/bloc/forgot_password_bloc/forgot_password_event.dart';

import '../../../../core/error/failure.dart';
import '../../data/model/create_password_response.dart';
import '../entities/login_via_email_entity.dart';

abstract class OnboardingRepository {
  Future<Either<Failure, List<CategoryModel>>> getAllCategories(
      NoParams noParams);
  Future<Either<Failure, SubCategoryResponseModel>>
      getSubCategoriesBasedOnCategories(GetSubCategoryEntity entity);
  Future<Either<Failure, RegisterResponseModel>> registerViaEmail(
      RegisterEmailEntity entity);
  Future<Either<Failure, VerifyOtpResponse>> verifyOtp(VerifyOtpEntity entity);
  Future<Either<Failure, UserResponseModel>> logInViaEmail(
      EmailLoginEntity entity);
  Future<Either<Failure, UpdateUserDetailsModel>> updateUserDetails(
      UpdateUserDetailsEntity entity);
  Future<Either<Failure, SocialAuthModel>> socialAuth(SocialAuthEntity entity);
  Future<Either<Failure,VerifyEmailResponse>> checkEmail(SubmitEmailEntity entity);
  Future<Either<Failure,VerifyOtpResponse>> checkOtp(VerifyOtpEntity entity);
  Future<Either<Failure,CreatePasswordResponse>> createPassword(ChangePasswordEntity entity);
}
