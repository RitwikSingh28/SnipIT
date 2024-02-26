import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:snipit/core/constants/app_colors.dart';
import 'package:snipit/core/constants/app_data.dart';
import 'package:snipit/core/constants/app_icons.dart';
import 'package:snipit/core/constants/app_text_styles.dart';
import 'package:snipit/core/utils/custom_spacers.dart';
import 'package:snipit/core/utils/screen_utils.dart';
import 'package:snipit/features/onboarding/data/model/category_model.dart';
import 'package:snipit/features/onboarding/data/model/subcategory_model.dart';
import 'package:snipit/features/onboarding/presentation/bloc/category/category_bloc.dart';
import 'package:snipit/features/onboarding/presentation/bloc/category/category_event.dart';
import 'package:snipit/features/onboarding/presentation/bloc/category/category_state.dart';
import 'package:snipit/features/onboarding/presentation/widgets/category_tile_widget.dart';
import 'package:snipit/route/app_pages.dart';
import 'package:snipit/route/custom_navigator.dart';
import 'package:snipit/ui/injection_container.dart';
import 'package:snipit/ui/molecules/custom_button.dart';

import '../../../../ui/molecules/custom_scaffold.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool _isSelected = false;
  CategoryBloc bloc = sl<CategoryBloc>();
  List<CategoryModel> _availableCategories = [];
  List<CategoryModel> _selectedCategories = [];
  List<CategoryModel> _previouslySelectedCategories = []; // For Edit mode only
  List<SubcategoryModel> _previouslySelectedSubCategoies =
      []; // For Edit mode only
  bool isEdit = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final Map<String, dynamic> args =
          ModalRoute.of(context)?.settings.arguments != null
              ? ModalRoute.of(context)?.settings.arguments
                  as Map<String, dynamic>
              : {};
      if (args["selectedCategories"] != null) {
        _previouslySelectedCategories = args["selectedCategories"];
        _previouslySelectedSubCategoies =
            args['previouslySelectedSubCategories'];
        if (_previouslySelectedCategories.isNotEmpty) {
          isEdit = true;
        }
      }

      bloc.add(GetCategoryEvent());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 7),
          child: SizedBox(
              width: 60.w,
              height: 15.33.h,
              child: SvgPicture.asset(
                AppIcons.app_icon,
                alignment: Alignment.centerRight,
              )),
        ),
      ],
      body: BlocProvider<CategoryBloc>(
        create: (context) => bloc,
        child: BlocListener<CategoryBloc, CategoryState>(
          listener: (context, state) {
            if (state is CategoryButtonSelectedState) {
              _isSelected = state.isSelected;
            }
            if (state is CategoryLoadedState) {
              _selectedCategories.addAll(_previouslySelectedCategories);
              _availableCategories = state.categories;
            }
          },
          child: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              return SizedBox(
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
                          bgColor: _selectedCategories.isEmpty
                              ? AppColors.primary.withOpacity(0.4)
                              : AppColors.primary,
                          strButtonText: "Continue",
                          buttonAction: () {
                            var selectedCategoryIds =
                                _selectedCategories.map((e) => e.id).toList();
                            var args = {
                              'selectedCategories': selectedCategoryIds,
                              'isEdit': isEdit,
                              'selectedSubCategories':
                                  _previouslySelectedSubCategoies
                            };
                            if (_selectedCategories.isNotEmpty) {
                              CustomNavigator.pushTo(
                                  context, AppPages.subcategory,
                                  arguments: args);
                            }
                          },
                          textColor: AppColors.black,
                          textStyle: AppTextStyles.textStyles_MN_30_600_black
                              .copyWith(
                                  fontSize: 16,
                                  color: _selectedCategories.isNotEmpty
                                      ? AppColors.black
                                      : AppColors.black.withOpacity(0.5)),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _buildHeader() => SizedBox(
        // height: 82.h,
        // width: 383.w,
        child: RichText(
          textAlign: TextAlign.start,
          text: const TextSpan(children: [
            TextSpan(
                text: "Which of these themes ",
                style: AppTextStyles.textStyles_MN_30_400_black),
            TextSpan(
                text: "interest you?",
                style: AppTextStyles.textStyles_MN_30_600_black)
          ]),
        ),
      );

  _buildCategory() => SizedBox(
          // width: 362.w,
          // height: 360.h,
          child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 35.h,
        ),
        itemCount: _availableCategories.length,
        itemBuilder: (context, index) {
          _isSelected =
              _selectedCategories.contains(_availableCategories[index]);
          print(_isSelected);

          return CategoryTileWidget(
            category: _availableCategories[index],
            isSelected: _isSelected,
            onTap: (a) {
              if (a == true) {
                bloc.add(CategoryButtonSelectedEvent(a));
                bloc.add(CategoryButtonSelectedEvent(false));
                _selectedCategories.add(_availableCategories[index]);
              } else {
                bloc.add(CategoryButtonSelectedEvent(a));
                bloc.add(CategoryButtonSelectedEvent(true));
                _selectedCategories
                    .removeWhere((item) => item == _availableCategories[index]);
              }
            },
          );
        },
      ));
}
