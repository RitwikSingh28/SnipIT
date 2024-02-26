import 'package:bloc/bloc.dart';
import 'package:snipit/core/constants/usecase/usecase_interface.dart';
import 'package:snipit/core/constants/value_constants.dart';
import 'package:snipit/core/helpers/ui_helpers.dart';
import 'package:snipit/features/onboarding/domain/usecases/get_category_usecase.dart';
import 'package:snipit/features/onboarding/presentation/bloc/category/category_event.dart';
import 'package:snipit/features/onboarding/presentation/bloc/category/category_state.dart';
import 'package:snipit/utils/overlay-manager.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  GetCategoryUseCase getCategoryUseCase;
  CategoryBloc({required this.getCategoryUseCase}) : super(CategoryInitial()) {
    on<CategoryButtonSelectedEvent>((event, emit) {
      emit(CategoryButtonSelectedState(isSelected: event.isSelected));
    });
    on<GetCategoryEvent>((event, emit) async {
      UiHelpers.showLoader();
      final result = await getCategoryUseCase(NoParams());
      result.fold((failure) {
        OverlayManager.showToast(
            type: ToastType.Error, msg: "Failed to load categories");
        UiHelpers.hideKeyboard();
      }, (loaded) {
        UiHelpers.hideLoader();
        emit(CategoryLoadedState(categories: loaded));
      });
    });
  }
}
