import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:snipit/core/constants/app_colors.dart';
import 'package:snipit/core/constants/app_data.dart';
import 'package:snipit/core/constants/app_icons.dart';
import 'package:snipit/core/constants/app_text_styles.dart';
import 'package:snipit/core/constants/value_constants.dart';
import 'package:snipit/core/helpers/ui_helpers.dart';
import 'package:snipit/core/utils/custom_spacers.dart';
import 'package:snipit/core/utils/screen_utils.dart';
import 'package:snipit/features/feed/data/datasource/feed_data_source.dart';
import 'package:snipit/features/onboarding/data/model/subcategory_model.dart';
import 'package:snipit/features/onboarding/domain/entities/get-subcategories-entity.dart';
import 'package:snipit/features/onboarding/presentation/bloc/subcategory/subcategory_bloc.dart';
import 'package:snipit/features/onboarding/presentation/bloc/subcategory/subcategory_event.dart';
import 'package:snipit/features/onboarding/presentation/bloc/subcategory/subcategory_state.dart';
import 'package:snipit/features/onboarding/presentation/widgets/category_tile_widget.dart';
import 'package:snipit/features/onboarding/presentation/widgets/subcategory_tile_widget.dart';
import 'package:snipit/features/profile/domain/entity/update_category_entity.dart';
import 'package:snipit/route/app_pages.dart';
import 'package:snipit/route/custom_navigator.dart';
import 'package:snipit/ui/injection_container.dart';
import 'package:snipit/ui/molecules/custom_button.dart';
import 'package:snipit/utils/overlay-manager.dart';

import '../../../../ui/molecules/custom_scaffold.dart';

class SubcategoryPage extends StatefulWidget {
  const SubcategoryPage({
    super.key,
  });

  @override
  State<SubcategoryPage> createState() => _SubcategoryPageState();
}

class _SubcategoryPageState extends State<SubcategoryPage> {
  bool _isSelected = false;
  List<String> _selectedCategoryIds = [];
  List<SubcategoryModel> _availableSubcategories = [];
  List<SubcategoryModel> _selectedSubCategories = [];
  List<SubcategoryModel> _previouslySelectedSubCategories = [];
  bool _isEdit = false;

  SubcategoryBloc bloc = sl<SubcategoryBloc>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final Map<String, dynamic> args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      _selectedCategoryIds = args["selectedCategories"];

      if (args["isEdit"] != null) {
        _isEdit = args['isEdit'];
      }
      if (args['selectedSubCategories'] != null) {
        _previouslySelectedSubCategories = args['selectedSubCategories'];
      }
      if (_selectedCategoryIds.isNotEmpty) {
        bloc.add(GetSubCategoryEvent(
            entity: GetSubCategoryEntity(categoriIds: _selectedCategoryIds)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SubcategoryBloc>(
        create: (context) => bloc,
        child: BlocListener<SubcategoryBloc, SubcategoryState>(
          listener: (context, state) {
            if (state is SubCategoriesLoadedState) {
              var subcategoriesToAdd = _previouslySelectedSubCategories.where(
                  (element) =>
                      _selectedCategoryIds.contains(element.categoryId));

              _selectedSubCategories.addAll(subcategoriesToAdd);
              _availableSubcategories = state.subCategoryResponse;
            }
          },
          child: BlocBuilder<SubcategoryBloc, SubcategoryState>(
            builder: (context, state) {
              return CustomScaffold(
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 7),
                    child: SizedBox(
                        width: 60.w,
                        height: 15.33.h,
                        child: SvgPicture.asset(
                          AppIcons.app_icon,
                          alignment: Alignment.centerRight,
                        )),
                  ),
                ],
                body: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomSpacers.height52,
                            _buildHeader(),
                            CustomSpacers.height45,
                            _buildCategory(),
                            SizedBox(height: 200),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: CustomButton(
                            bgColor: AppColors.primary.withOpacity(
                                _selectedSubCategories.isNotEmpty ? 1 : 0.5),
                            strButtonText:
                                _isEdit ? "Update Preferences" : "Continue",
                            buttonAction: () async {
                              if (_selectedSubCategories.isNotEmpty) {
                                var args = {
                                  'selectedCategories': _selectedCategoryIds,
                                  'selectedSubcategories':
                                      _selectedSubCategories
                                          .map((e) => e.id)
                                          .toList()
                                };
                                if (_isEdit) {
                                  //TODO: Call API & Save Data
                                  var ds = sl<FeedDataSource>();
                                  var response = await ds.updateCategory(
                                      UpdateCategoryEntity(
                                          categories: _selectedCategoryIds,
                                          subcategories: _selectedSubCategories
                                              .map((e) => e.id)
                                              .toList()));
                                  if (response.success) {
                                    OverlayManager.showToast(
                                        type: ToastType.Success,
                                        msg:
                                            "Preferences Updated Successfully!");
                                    CustomNavigator.pop(context);
                                    CustomNavigator.pop(
                                      context,
                                    );
                                  }

                                  return;
                                }
                                CustomNavigator.pushTo(
                                    context, AppPages.signUpLanding,
                                    arguments: args);
                              }
                            },
                            textColor: AppColors.black,
                            textStyle: AppTextStyles.textStyles_MN_30_600_black
                                .copyWith(fontSize: 16, color: AppColors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }

  _buildHeader() => SizedBox(
        // height: 82.h,
        // width: 383.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              textAlign: TextAlign.start,
              text: const TextSpan(children: [
                TextSpan(
                    text: "Which of these sub themes ",
                    style: AppTextStyles.textStyles_MN_30_400_black),
                TextSpan(
                    text: "interest you?",
                    style: AppTextStyles.textStyles_MN_30_600_black)
              ]),
            ),
            CustomSpacers.height4,
            Text('Curated based on your theme selections',
                style: AppTextStyles.defaultTextStyle.copyWith(fontSize: 16))
          ],
        ),
      );

  _buildCategory() => SizedBox(
      // width: 362.w,
      height: MediaQuery.of(context).size.height * 0.5,
      child: GridView.builder(
        shrinkWrap: true,
        // physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 35.h,
        ),
        itemCount: _availableSubcategories.length,
        itemBuilder: (context, index) {
          _isSelected =
              _selectedSubCategories.contains(_availableSubcategories[index]);

          return CategoryTileWidget(
            category: _availableSubcategories[index],
            isSelected: _isSelected,
            onTap: (a) {
              if (a == true) {
                bloc.add(SubcategoryButtonSelectedEvent(a));
                bloc.add(SubcategoryButtonSelectedEvent(false));
                _selectedSubCategories.add(_availableSubcategories[index]);
              } else {
                bloc.add(SubcategoryButtonSelectedEvent(a));
                bloc.add(SubcategoryButtonSelectedEvent(true));
                _selectedSubCategories.removeWhere(
                    (item) => item == _availableSubcategories[index]);
              }
            },
          );
        },
      ));
}
