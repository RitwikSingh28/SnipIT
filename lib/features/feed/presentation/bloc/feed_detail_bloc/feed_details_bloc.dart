import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snipit/core/helpers/ui_helpers.dart';
import 'package:snipit/features/feed/presentation/bloc/feed_detail_bloc/feed_detail_event.dart';
import 'package:snipit/features/feed/presentation/bloc/feed_detail_bloc/feed_detail_state.dart';

import '../../../../../core/constants/value_constants.dart';
import '../../../../../utils/overlay-manager.dart';
import '../../../domain/usecases/add_interaction_usecase.dart';

class FeedDetailBloc extends Bloc<FeedDetailEvent,FeedDetailState>{
  AddInteractionUseCase addInteractionUseCase;
  FeedDetailBloc({required this.addInteractionUseCase}):super(FeedDetailInitialState()){
  on<AddInteractionEvent>((event, emit)async{
    UiHelpers.showLoader();
    final result = await addInteractionUseCase(event.entity);
    result.fold((failure) {
      UiHelpers.hideLoader();
      OverlayManager.showToast(
          type: ToastType.Error, msg: "Something went wrong");
    }, (loaded) {
      if(loaded.success!){
        UiHelpers.hideLoader();
      }
      else{
        OverlayManager.showToast(
            type: ToastType.Error, msg: "Something went wrong");
        UiHelpers.hideLoader();
      }
    });
  });
  }
}