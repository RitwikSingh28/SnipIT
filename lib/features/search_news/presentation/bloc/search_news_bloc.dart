import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snipit/features/search_news/domain/entity/search_news_entity.dart';
import 'package:snipit/features/search_news/presentation/bloc/search_news_event.dart';
import 'package:snipit/features/search_news/presentation/bloc/search_news_state.dart';

import '../../../../core/constants/value_constants.dart';
import '../../../../core/helpers/ui_helpers.dart';
import '../../../../utils/overlay-manager.dart';
import '../../domain/usecases/search_news_usecase.dart';

class SearchNewsBloc extends Bloc<SearchNewsEvent, SearchNewsState> {
  SearchNewsUseCase searchNewsUseCase;
  SearchNewsBloc({required this.searchNewsUseCase})
      : super(SearchNewsInitialState()) {
    int _skip = 0;
    int _limit = 8;
    int totalResults = 0;
    on<SearchNews>((event, emit) async {
      if (event.searchTerm.length <= 3) {
        emit(SearchQueryInvalidState());
      } else {
        if (_skip == 0) {
          emit(SearchNewsLoadingState());
        } else if (_skip > totalResults) {
          return;
        }
        SearchNewsEntity entity = SearchNewsEntity(
            searchTerm: event.searchTerm, skip: _skip, limit: _limit);
        final result = await searchNewsUseCase(entity);
        result.fold((failure) {
          OverlayManager.showToast(
              type: ToastType.Error, msg: "Failed to get articles");
          UiHelpers.hideKeyboard();
        }, (loaded) {
          totalResults = loaded.total;
          emit(SearchNewsSuccessState(news: loaded.news));
          _skip += _limit;
        });
      }
    });

    on<RefreshEvent>((event, emit) {
      _skip = 0;
      totalResults = 0;
    });
  }
}
