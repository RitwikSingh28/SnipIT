import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snipit/features/account/presentation/bloc/update_user_name_event.dart';
import 'package:snipit/features/account/presentation/bloc/update_user_name_state.dart';
import 'package:snipit/features/onboarding/domain/entities/update_user_details_entity.dart';
import '../../../../core/constants/value_constants.dart';
import '../../../../core/helpers/ui_helpers.dart';
import '../../../../utils/overlay-manager.dart';
import '../../../onboarding/domain/usecases/update_user_details_usecase.dart';
import '../../domain/usecases/check_user_name_usecase.dart';

class UpdateUserNameBloc
    extends Bloc<UpdateUserNameEvent, UpdateUserNameState> {
  CheckUserNameUseCase checkUserNameUseCase;
  UpdateUserDetailsUseCase updateUserDetailsUseCase;
  UpdateUserNameBloc(
      {required this.checkUserNameUseCase,
      required this.updateUserDetailsUseCase})
      : super(UpdateUserNameInitialState()) {
    on<CheckUserName>(checkUserName);
    on<UpdateUserName>(updateUserName);
  }

  checkUserName(CheckUserName event, Emitter<UpdateUserNameState> emit) async {
    final result = await checkUserNameUseCase(event.entity);
    result.fold((failure) {
      emit(UserNameNotAvailableState());
      UiHelpers.hideKeyboard();
    }, (loaded) async {
      emit(UserNameAvailableState(loaded: loaded));
      UiHelpers.hideLoader();
    });
  }

  updateUserName(
      UpdateUserName event, Emitter<UpdateUserNameState> emit) async {
    UiHelpers.showLoader();
    UpdateUserDetailsEntity updateUserDetailsEntity =
        UpdateUserDetailsEntity(userName: event.userName);
    final result = await updateUserDetailsUseCase(updateUserDetailsEntity);
    result.fold((failure) {
      UiHelpers.hideLoader();
      OverlayManager.showToast(
          type: ToastType.Error, msg: "Something went wrong");
      UiHelpers.hideKeyboard();
    }, (loaded) {
      emit(UpdateUserNameSuccessState());
      UiHelpers.hideLoader();
    });
  }
}
