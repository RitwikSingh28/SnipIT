import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:snipit/core/helpers/user_helpers.dart';
import 'package:snipit/features/account/presentation/bloc/update_user_profile_event.dart';
import 'package:snipit/features/account/presentation/bloc/update_user_profile_state.dart';
import 'package:snipit/features/onboarding/domain/usecases/update_user_details_usecase.dart';
import '../../../../../core/constants/value_constants.dart';
import '../../../../../core/helpers/ui_helpers.dart';
import '../../../../../utils/overlay-manager.dart';

class UpdateUserProfileBloc
    extends Bloc<UpdateUserProfileEvent, UpdateUserProfileState> {
  UpdateUserDetailsUseCase updateUserDetailsUseCase;
  UpdateUserProfileBloc({required this.updateUserDetailsUseCase})
      : super(UpdateUserProfileInitial()) {
    on<PutUserProfileEvent>(putUserDetails);

    on<PickImageEvent>((event, emit) => emit(const UpdateUserProfileState()
        .copyWith(pickedFile: event.pickedImage)));
  }

  FutureOr<void> putUserDetails(
      PutUserProfileEvent event, Emitter<UpdateUserProfileState> emit) async {
    UiHelpers.showLoader();
    final result = await updateUserDetailsUseCase(event.entity);
    result.fold((failure) {
      UiHelpers.hideLoader();
      OverlayManager.showToast(
          type: ToastType.Error, msg: "Failed to Update user Details");
      UiHelpers.hideKeyboard();
    }, (loaded) {
      UiHelpers.hideLoader();
      print(loaded.user.firstName);
      UserHelpers.setUserDetails(loaded.user);
      emit(UpdateUserProfileSuccess());
    });
  }
}
