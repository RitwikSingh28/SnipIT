import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snipit/core/constants/usecase/usecase_interface.dart';
import 'package:snipit/core/constants/value_constants.dart';
import 'package:snipit/core/helpers/ui_helpers.dart';
import 'package:snipit/core/helpers/user_helpers.dart';
import 'package:snipit/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:snipit/features/feed/data/models/get_news_by_category_model.dart';
import 'package:snipit/features/feed/data/models/news_model.dart';
import 'package:snipit/features/feed/data/models/user_preference_model.dart';
import 'package:snipit/features/feed/domain/entity/get_newsby_category_entity.dart';
import 'package:snipit/features/feed/domain/usecases/get_my_news_usecase.dart';
import 'package:snipit/features/feed/domain/usecases/get_news_by_category_usecase.dart';
import 'package:snipit/features/feed/domain/usecases/get_preference_usecase.dart';
import 'package:snipit/features/feed/domain/usecases/like_newsby_id_usecase.dart';
import 'package:snipit/features/onboarding/domain/entities/like_newsby_id_entity.dart';
import 'package:snipit/utils/overlay-manager.dart';

import '../../domain/entity/get_my_news_entity.dart';
part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  GetPreferenceUseCase getPreferenceUsecase;
  GetNewsByCategoryUseCase getNewsByCategoryUseCase;
  GetMyNewsUseCase getMyNewsUsecase;
  LikeNewsByIdUseCase likeNewsUseCase;
  int _limit=8;
  int _skip=0;
  int _totalNews=0;

  FeedBloc(
      {required this.getPreferenceUsecase,
      required this.getNewsByCategoryUseCase,
      required this.getMyNewsUsecase,
      required this.likeNewsUseCase})
      : super(FeedInitial()) {
    on<FeedEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetPreferencesEvent>(
      (event, emit) async {
        final result = await getPreferenceUsecase(NoParams());
        result.fold((failure) {
          OverlayManager.showToast(
              type: ToastType.Error, msg: "Failed to get preferences");
          UiHelpers.hideKeyboard();
        }, (loaded) {
          UserHelpers.setPreferences(loaded.preference);
          emit(PreferencesLoadedState(userPreferenceModel: loaded.preference));
        });
      },
    );
    on<ChangeCategoryTabEvent>((event, emit) {
      _skip=0;
      emit(ChangeNewsTabSuccessState(index: event.index));
    });
    on<GetNewsByCategoryEvent>((event, emit) async {
      UiHelpers.showLoader();
      GetNewsByCategoryEntity entity=GetNewsByCategoryEntity(category: event.category, skip: _skip, limit: _limit);
      final result = await getNewsByCategoryUseCase(entity);
      result.fold((failure) {
        UiHelpers.hideLoader();
        OverlayManager.showToast(
            type: ToastType.Error, msg: "Failed to get articles");
        UiHelpers.hideKeyboard();
      }, (loaded) {
        UiHelpers.hideLoader();
        emit(GetNewsSuccessState(news: loaded.news));
      });
    });
    on<LikeNewsEvent>((event, emit) async {
      final result = await likeNewsUseCase(event.entity);
      result.fold((failure) {
        OverlayManager.showToast(
            type: ToastType.Error, msg: "Failed to like the article");
      }, (loaded) {
        emit(LikeNewsSuccessState(
            newsId: event.entity.newsId,
            newsIndex: event.newsIndex,
            timestamp: DateTime.now()));
      });
    });

    on<GetMyNewsEvent>((event, emit) async {
      if(_skip==0 || _totalNews>=_skip){
        // if(_skip==0){
        //   UiHelpers.showLoader();
        // }
        final result = await getMyNewsUsecase(GetMyNewsEntity(skip: _skip,limit: _limit));
        result.fold((failure) {
          OverlayManager.showToast(
              type: ToastType.Error, msg: "Failed to get articles");
          UiHelpers.hideKeyboard();
        }, (loaded) {
          _totalNews=loaded.total;
          emit(GetNewsSuccessState(news: loaded.news));
        });
        _skip += _limit;
      }
    });

  }
}
