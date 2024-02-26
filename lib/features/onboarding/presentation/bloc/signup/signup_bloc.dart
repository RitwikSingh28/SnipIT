import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snipit/core/constants/value_constants.dart';
import 'package:snipit/core/helpers/ui_helpers.dart';
import 'package:snipit/core/helpers/user_helpers.dart';
import 'package:snipit/features/onboarding/data/model/register_response_model.dart';
import 'package:snipit/features/onboarding/data/model/social_auth_model.dart';
import 'package:snipit/features/onboarding/data/model/verify_otp_response.dart';
import 'package:snipit/features/onboarding/domain/entities/register-email-entity.dart';
import 'package:snipit/features/onboarding/domain/entities/social_auth_entity.dart';
import 'package:snipit/features/onboarding/domain/entities/verify-otp-event.dart';
import 'package:snipit/features/onboarding/domain/usecases/register_via_email_usecase.dart';
import 'package:snipit/features/onboarding/domain/usecases/social_auth_usecase.dart';
import 'package:snipit/features/onboarding/domain/usecases/verify_otp_usecase.dart';
import 'package:snipit/utils/overlay-manager.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  RegisterViaEmailUseCase registerViaEmailUseCase;
  VerifyOtpUseCase verifyOtpUseCase;
  SocialAuthUseCase socialAuthUseCase;
  String email = '';
  SignupBloc(
      {required this.registerViaEmailUseCase,
      required this.verifyOtpUseCase,
      required this.socialAuthUseCase})
      : super(SignupInitial()) {
    on<SignupEvent>((event, emit) {});
    on<RegisterViaEmailEvent>(registerViaEmail);
    on<VerifyOtpEvent>(_verifyOtp);
    on<RegisterViaOAuthEvent>(_registerViaOAuth);
  }
  _registerViaOAuth(RegisterViaOAuthEvent event, emit) async {
    UiHelpers.showLoader();
    final result = await socialAuthUseCase(event.entity);
    result.fold((failure) {
      UiHelpers.hideLoader();
      OverlayManager.showToast(
          type: ToastType.Error,
          msg: "Failed to register user ${failure.message}");
      UiHelpers.hideKeyboard();
    }, (loaded) {
      UiHelpers.hideLoader();
      emit(SocialAuthSuccessState(model: loaded));
    });
  }

  registerViaEmail(
      RegisterViaEmailEvent event, Emitter<SignupState> emit) async {
    // UiHelpers.showLoader();
    final result = await registerViaEmailUseCase(event.entity);
    email = event.entity.email;
    result.fold((failure) {
      OverlayManager.showToast(
          type: ToastType.Error,
          msg: "Failed to register user ${failure.message}");
      UiHelpers.hideKeyboard();
    }, (loaded) {
      UiHelpers.hideLoader();
      UserHelpers.setUserDetails(loaded.user);
      emit(RegisterViaEmailSuccessState(registerResponse: loaded));
    });
  }

  _verifyOtp(VerifyOtpEvent event, Emitter<SignupState> emit) async {
    UiHelpers.showLoader();
    final result = await verifyOtpUseCase(
        VerifyOtpEntity(email: event.entity.email, otp: event.entity.otp));
    result.fold((failure) {
      UiHelpers.hideLoader();
      OverlayManager.showToast(
          type: ToastType.Error, msg: "Failed to register user");
      UiHelpers.hideKeyboard();
    }, (loaded) {
      UserHelpers.setAuthToken(loaded.token);
      print(loaded.token);
      UiHelpers.hideLoader();
      emit(OtpVerifiedState(response: loaded));
    });
  }
}
