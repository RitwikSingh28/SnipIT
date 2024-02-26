import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snipit/core/constants/usecase/usecase_interface.dart';
import 'package:snipit/core/constants/value_constants.dart';
import 'package:snipit/core/helpers/ui_helpers.dart';
import 'package:snipit/core/helpers/user_helpers.dart';
import 'package:snipit/features/discover/data/models/discover_response_model.dart';
import 'package:snipit/features/discover/domain/usecases/get_discover_themes_usecase.dart';
import 'package:snipit/features/discover/domain/usecases/update_discover_themes_usecase.dart';
import 'package:snipit/features/feed/data/models/user_preference_response.dart';
import 'package:snipit/utils/overlay-manager.dart';

part 'discovery_event.dart';
part 'discovery_state.dart';

class DiscoveryBloc extends Bloc<DiscoveryEvent, DiscoveryState> {
  GetDiscoverThemesUseCase getDiscoverThemesUseCase;
  UpdateDiscoverThemesUsecase updateDiscoverThemesUsecase;

  DiscoveryBloc(
      {required this.getDiscoverThemesUseCase,
      required this.updateDiscoverThemesUsecase})
      : super(DiscoveryInitial()) {
    on<DiscoveryEvent>((event, emit) {});
    on<GetDiscoverOptionsEvent>(
      (event, emit) async {
        UiHelpers.showLoader();
        var result = await getDiscoverThemesUseCase(NoParams());
        result.fold((failure) {
          UiHelpers.hideLoader();
          OverlayManager.showToast(type: ToastType.Error, msg: failure.message);
        }, (loaded) {
          UiHelpers.hideLoader();
          emit(DiscoverOptionsLoadedState(discoveries: loaded.discoverThemes));
        });
      },
    );

    on<UpdateDiscoverOptionsEvent>((event, emit) async {
      UiHelpers.showLoader();
      var result = await updateDiscoverThemesUsecase(event.discoverIds);
      result.fold((failure) {
        UiHelpers.hideLoader();
        OverlayManager.showToast(type: ToastType.Error, msg: failure.message);
      }, (loaded) {
        UiHelpers.hideLoader();
        UserHelpers.setPreferences(loaded.preference);
        emit(DiscoverOptionUpdatedState(response: loaded));
      });
    });
  }
}
