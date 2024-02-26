import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snipit/core/helpers/pick_image.dart';
import 'package:snipit/core/helpers/user_helpers.dart';
import 'package:snipit/features/onboarding/data/model/userModel.dart';
import 'package:snipit/features/onboarding/domain/usecases/update_user_details_usecase.dart';
import '../../../../../core/constants/value_constants.dart';
import '../../../../../core/helpers/media_uploader.dart';
import '../../../../../core/helpers/ui_helpers.dart';
import '../../../../../utils/overlay-manager.dart';
import '../../../data/model/update_user_details_model.dart';
import '../../../domain/entities/update_user_details_entity.dart';

part 'update_user_details_event.dart';
part 'update_user_details_state.dart';

class UpdateUserDetailsBloc
    extends Bloc<UpdateUserDetailsEvent, UpdateUserDetailsState> {
  String firstName = "";
  String lastName = "";
  String phone = "";
  UpdateUserDetailsUseCase updateUserDetailsUseCase;
  UpdateUserDetailsBloc({required this.updateUserDetailsUseCase})
      : super(UpdateUserDetailsInitial()) {
    on<UpdateUserDetailsEvent>((event, emit) {});
    on<PutUserDetailsEvent>(putUserDetails);

    on<ImagePickedEvent>((event, emit) => emit(const UpdateUserDetailsState().copyWith(pickedFile: event.pickedImage)));

    
  }

  FutureOr<void> putUserDetails(
      PutUserDetailsEvent event, Emitter<UpdateUserDetailsState> emit) async {
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
      emit(UpdateUserDetailsSuccessState(userDetailsModel: loaded));
    });
  }
  
}
