import 'package:bloc/bloc.dart';
import 'package:snipit/core/constants/value_constants.dart';
import 'package:snipit/core/helpers/ui_helpers.dart';
import 'package:snipit/features/onboarding/domain/usecases/get_subcategory_usecase.dart';
import 'package:snipit/features/onboarding/presentation/bloc/subcategory/subcategory_event.dart';
import 'package:snipit/features/onboarding/presentation/bloc/subcategory/subcategory_state.dart';
import 'package:snipit/utils/overlay-manager.dart';

class SubcategoryBloc extends Bloc<SubcategoryEvent, SubcategoryState> {
  final GetSubcategoryUseCase getSubcategoryUseCase;
  SubcategoryBloc({required this.getSubcategoryUseCase})
      : super(SubcategoryInitial()) {
    on<SubcategoryButtonSelectedEvent>((event, emit) {
      emit(SubcategoryButtonSelectedState(isSelected: event.isSelected));
    });
    on<GetSubCategoryEvent>((event, emit) async {
      UiHelpers.showLoader();
      final result = await getSubcategoryUseCase(event.entity);
      result.fold((failure) {
        OverlayManager.showToast(
            type: ToastType.Error, msg: "Failed to load sub categories");
        UiHelpers.hideKeyboard();
      }, (loaded) {
        UiHelpers.hideLoader();
        emit(SubCategoriesLoadedState(
            subCategoryResponse: loaded.subCategories));
      });
    });
  }
}
