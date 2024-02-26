import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snipit/features/onboarding/presentation/bloc/forgot_password_bloc/forgot_password_event.dart';
import 'package:snipit/features/onboarding/presentation/bloc/forgot_password_bloc/forgot_password_state.dart';
import '../../../../../core/constants/value_constants.dart';
import '../../../../../core/helpers/ui_helpers.dart';
import '../../../../../utils/overlay-manager.dart';
import '../../../domain/usecases/check_email_use_case.dart';
import '../../../domain/usecases/check_otp_use_case.dart';
import '../../../domain/usecases/create_password_usecase.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent,ForgotPasswordState>{
  CheckEmailUseCase checkEmailUseCase;
  CheckOtpUseCase checkOtpUseCase;
  CreatePasswordUseCase createPasswordUseCase;
  ForgotPasswordBloc({required this.checkEmailUseCase,required this.checkOtpUseCase,required this.createPasswordUseCase}):super(ForgotPasswordInitialState()){
    on<EmailSubmitEvent>(submitEmailEvent);
    on<OtpSubmitEvent>(submitOtpEvent);
    on<CreateNewPasswordEvent>(createPasswordEvent);
    on<ResendOtpEvent>(resendOtpEvent);
  }


  submitEmailEvent(EmailSubmitEvent event,Emitter<ForgotPasswordState> emit)async{
    UiHelpers.showLoader();
    final result=await checkEmailUseCase(event.entity);
    result.fold((failure) {
      UiHelpers.hideLoader();
      OverlayManager.showToast(
          type: ToastType.Error, msg: "Something went wrong");
      UiHelpers.hideKeyboard();
    }, (loaded) {
      UiHelpers.hideLoader();
      if(loaded.status){
        emit(EmailRegisteredState());
      }
      else{
        OverlayManager.showToast(
            type: ToastType.Error, msg: "User does not exist");
      }
    });
  }

  resendOtpEvent(ResendOtpEvent event,Emitter<ForgotPasswordState> emit)async{
    UiHelpers.showLoader();
    final result=await checkEmailUseCase(event.entity);
    result.fold((failure) {
      UiHelpers.hideLoader();
      OverlayManager.showToast(
          type: ToastType.Error, msg: "Something went wrong");
      UiHelpers.hideKeyboard();
    }, (loaded) {
      UiHelpers.hideLoader();
      if(loaded.status){
        OverlayManager.showToast(
            type: ToastType.Success, msg: "Otp sent successfully");
      }
      else{
        OverlayManager.showToast(
            type: ToastType.Error, msg: "Something went wrong");
      }
    });
  }

  submitOtpEvent(OtpSubmitEvent event,Emitter<ForgotPasswordState> emit)async{
    UiHelpers.showLoader();
    final result=await checkOtpUseCase(event.entity);
    result.fold((failure) {
      UiHelpers.hideLoader();
      OverlayManager.showToast(
          type: ToastType.Error, msg: "Something went wrong");
      UiHelpers.hideKeyboard();
    }, (loaded) {
      UiHelpers.hideLoader();
      if(loaded.status){
        OverlayManager.showToast(
            type: ToastType.Success, msg: "Otp Verified");
        emit(OtpVerifiedState());
      }
      else{
        OverlayManager.showToast(
            type: ToastType.Error, msg: "Invalid Otp");
      }
    });
  }

  createPasswordEvent(CreateNewPasswordEvent event,Emitter<ForgotPasswordState> emit)async{
    UiHelpers.showLoader();
    final result=await createPasswordUseCase(event.entity);
    result.fold((failure) {
      UiHelpers.hideLoader();
      OverlayManager.showToast(
          type: ToastType.Error, msg: "Something went wrong");
      UiHelpers.hideKeyboard();
    }, (loaded) {
      if(loaded.status){
        OverlayManager.showToast(
            type: ToastType.Success, msg: "Password has been changed successfully");
        UiHelpers.hideLoader();
        emit(PasswordChangeSuccessState());
      }
      else{
        OverlayManager.showToast(
            type: ToastType.Error, msg: "Invalid Otp");
      }
    });
  }
}