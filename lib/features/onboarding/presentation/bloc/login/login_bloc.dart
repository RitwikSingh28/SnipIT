import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snipit/core/helpers/user_helpers.dart';
import 'package:snipit/features/onboarding/data/model/user_response_model.dart';
import 'package:snipit/features/onboarding/domain/usecases/login_via_email_usecase.dart';

import '../../../../../core/constants/value_constants.dart';
import '../../../../../core/helpers/ui_helpers.dart';
import '../../../../../utils/overlay-manager.dart';
import '../../../domain/entities/login_via_email_entity.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginViaEmailUsecase loginViaEmailUsecase;
  String email = '';
  String password = '';
  LoginBloc({required this.loginViaEmailUsecase}) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});
    on<LoginViaEmailEvent>(loginViaEmail);
  }

  loginViaEmail(LoginViaEmailEvent event, Emitter<LoginState> emit) async {
    UiHelpers.showLoader();
    final result = await loginViaEmailUsecase(event.entity);
    email = event.entity.email;
    password = event.entity.password;
    result.fold((failure) {
      UiHelpers.hideLoader();
      OverlayManager.showToast(
          type: ToastType.Error, msg: "Failed to login user");
      UiHelpers.hideKeyboard();
    }, (loaded) {
      UserHelpers.setAuthToken(loaded.token);
      UserHelpers.userDetails = loaded.user;
      UiHelpers.hideLoader();
      emit(LoginViaEmailSuccessState(userResponseModel: loaded));
    });
  }
}
