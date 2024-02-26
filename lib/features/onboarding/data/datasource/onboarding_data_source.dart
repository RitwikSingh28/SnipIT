import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:snipit/core/api/base/custom_http_client.dart';
import 'package:snipit/core/constants/url_constant.dart';
import 'package:snipit/core/constants/usecase/usecase_interface.dart';
import 'package:snipit/core/error/exception.dart';
import 'package:snipit/core/helpers/user_helpers.dart';
import 'package:snipit/features/onboarding/data/model/category_model.dart';
import 'package:snipit/features/onboarding/data/model/register_response_model.dart';
import 'package:snipit/features/onboarding/data/model/subcategory_model.dart';
import 'package:snipit/features/onboarding/data/model/subcategory_response_model.dart';
import 'package:snipit/features/onboarding/data/model/userModel.dart';
import 'package:snipit/features/onboarding/data/model/verify_otp_response.dart';
import 'package:snipit/features/onboarding/domain/entities/change_password_entity.dart';
import 'package:snipit/features/onboarding/domain/entities/get-subcategories-entity.dart';
import 'package:snipit/features/onboarding/domain/entities/register-email-entity.dart';
import 'package:snipit/features/onboarding/domain/entities/submit_email_entity.dart';
import 'package:snipit/features/onboarding/domain/entities/verify-otp-event.dart';
import '../../domain/entities/login_via_email_entity.dart';
import '../../domain/entities/social_auth_entity.dart';
import '../../domain/entities/update_user_details_entity.dart';
import '../model/create_password_response.dart';
import '../model/social_auth_model.dart';
import '../model/update_user_details_model.dart';
import '../model/user_response_model.dart';
import '../model/verify_email_response.dart';

abstract class OnBoardingDataSource {
  Future<List<CategoryModel>> getAllCategories(NoParams noParams);
  Future<SubCategoryResponseModel> getSubCategoriesBasedOnCategories(
      GetSubCategoryEntity entity);
  Future<RegisterResponseModel> registerViaEmail(RegisterEmailEntity entity);
  Future<VerifyOtpResponse> verifyOtp(VerifyOtpEntity entity);
  Future<UserResponseModel> logInViaEmail(EmailLoginEntity entity);
  Future<UpdateUserDetailsModel> updateUserDetails(
      UpdateUserDetailsEntity entity);
  Future<SocialAuthModel> socialAuth(SocialAuthEntity entity);
  Future<VerifyEmailResponse> checkEmail(SubmitEmailEntity entity);
  Future<VerifyOtpResponse> checkOtp(VerifyOtpEntity entity);
  Future<CreatePasswordResponse> createPassword(ChangePasswordEntity entity);
}

class OnboardingDataSourceImpl extends OnBoardingDataSource {
  CustomHttpClient customHttpClient = CustomHttpClient();
  @override
  Future<List<CategoryModel>> getAllCategories(NoParams noParams) async {
    List<CategoryModel> categories = [];
    final response = await customHttpClient.get(Uri.parse(categoryUrl));
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      for (var i in result) {
        categories.add(CategoryModel.fromMap(i));
      }
      return categories;
    } else if (response.statusCode == 404 || response.statusCode == 400) {
      throw ApiException(message: json.decode(response.body)["msg"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SubCategoryResponseModel> getSubCategoriesBasedOnCategories(
      GetSubCategoryEntity entity) async {
    List<SubcategoryModel> subCategories = [];
    String categories = '';
    for (var a in entity.categoriIds) {
      categories += a + ",";
    }
    final response = await customHttpClient
        .get(Uri.parse('$subcategoryUrl?selectedCategory=$categories'));
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      for (var i in result) {
        subCategories.add(SubcategoryModel.fromMap(i));
      }
      return SubCategoryResponseModel(subCategories: subCategories);
    } else if (response.statusCode == 404 || response.statusCode == 400) {
      throw ApiException(message: json.decode(response.body)["msg"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<RegisterResponseModel> registerViaEmail(
      RegisterEmailEntity entity) async {
    final response = await customHttpClient.post(
        Uri.parse(registerViaEmailUrl), entity.toJson());
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = json.decode(response.body);
      if (!result['success']) {
        throw ApiException(message: result['message']);
      }
      return RegisterResponseModel.fromMap(result);
    } else if (response.statusCode == 404 ||
        response.statusCode == 400 ||
        response.statusCode == 409) {
      throw ApiException(message: json.decode(response.body)["message"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<VerifyOtpResponse> verifyOtp(VerifyOtpEntity entity) async {
    final response =
        await customHttpClient.post(Uri.parse(verifyOtpUrl), entity.toJson());
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      return VerifyOtpResponse.fromMap(result);
    } else if (response.statusCode == 404 || response.statusCode == 400) {
      throw ApiException(message: json.decode(response.body)["msg"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserResponseModel> logInViaEmail(EmailLoginEntity entity) async {
    final response = await customHttpClient.post(
        Uri.parse(userLoginUrl), jsonEncode(entity.toJson()));
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      return UserResponseModel.fromJson(result);
    } else if (response.statusCode == 404) {
      throw ApiException(message: json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UpdateUserDetailsModel> updateUserDetails(
      UpdateUserDetailsEntity entity) async {
    print(entity.toJson());
    print(putUserDetailsUrl);
    final response = await customHttpClient.put(
        Uri.parse(putUserDetailsUrl), jsonEncode(entity.toJson()));
    log(response.body);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      print(result["data"]["user"]);
      UserModel userModel=UserModel.fromJson(jsonEncode(result["data"]["user"]));
      await UserHelpers.setUserDetails(userModel);
      return UpdateUserDetailsModel.fromMap(result);
    } else if (response.statusCode == 404) {
      throw ApiException(message: json.decode(response.body)['message']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SocialAuthModel> socialAuth(SocialAuthEntity entity) async {
    final response = await customHttpClient.post(
        Uri.parse(socialAuthUrl), jsonEncode(entity.toJson()));
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      return SocialAuthModel.fromJson(result); //
    } else if (response.statusCode == 404) {
      throw ApiException(message: json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<VerifyEmailResponse> checkEmail(SubmitEmailEntity entity) async{
  final response=await customHttpClient.post(Uri.parse(resetPasswordViaEmail),jsonEncode(entity.toJson()));
  log(response.body);
  var result = json.decode(response.body);
  if(response.statusCode==200){
    return VerifyEmailResponse.fromMap(result);
  }
  else if(response.statusCode==404 || response.statusCode==200){
    throw ApiException(message: json.decode(response.body));
  }
  else{
    throw ServerException();
  }
  }

  @override
  Future<VerifyOtpResponse> checkOtp(VerifyOtpEntity entity) async{
    final response=await customHttpClient.post(Uri.parse(verifyUserOtpUrl),entity.toJson());
    log(verifyUserOtpUrl);
    log(response.body);
    log(entity.toJson());
    var result = json.decode(response.body);
    if(response.statusCode==200){
      return VerifyOtpResponse.fromMap(result);
    }
    else if(response.statusCode==404 || response.statusCode==400){
      throw ApiException(message: json.decode(response.body));
    }
    else{
      throw ServerException();
    }
  }

  @override
  Future<CreatePasswordResponse> createPassword(ChangePasswordEntity entity) async{
    final response=await customHttpClient.post(Uri.parse(updatePassword),jsonEncode(entity.toJson()));
    log(updatePassword);
    log(response.body);
    var result = json.decode(response.body);
    if(response.statusCode==200){
      return CreatePasswordResponse.fromMap(result);
    }
    else if(response.statusCode==404 || response.statusCode==400){
      throw ApiException(message: json.decode(response.body));
    }
    else{
      throw ServerException();
    }
  }
}
