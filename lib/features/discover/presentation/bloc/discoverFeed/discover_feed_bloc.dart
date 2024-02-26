import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snipit/core/constants/usecase/usecase_interface.dart';
import 'package:snipit/core/constants/value_constants.dart';
import 'package:snipit/core/helpers/ui_helpers.dart';
import 'package:snipit/core/helpers/user_helpers.dart';
import 'package:snipit/features/discover/domain/usecases/get_discover_news.dart';
import 'package:snipit/features/feed/data/models/get_news_by_category_model.dart';
import 'package:snipit/utils/overlay-manager.dart';

part 'discover_feed_event.dart';
part 'discover_feed_state.dart';

class DiscoverFeedBloc extends Bloc<DiscoverFeedEvent, DiscoverFeedState> {
  final GetDiscoverNewsUseCase getDiscoverNewsUseCase;
  DiscoverFeedBloc({required this.getDiscoverNewsUseCase})
      : super(DiscoverFeedInitial()) {
    on<DiscoverFeedEvent>((event, emit) {});
    on<GetDiscoverNewsEvent>((event, emit) async {
      UiHelpers.showLoader();
      var result = await getDiscoverNewsUseCase(NoParams());
      result.fold((failure) {
        UiHelpers.hideLoader();
        OverlayManager.showToast(type: ToastType.Error, msg: failure.message);
      }, (loaded) {
        UiHelpers.hideLoader();
        emit(DiscoverNewsLoadedState(response: loaded));
      });
    });
  }
}
