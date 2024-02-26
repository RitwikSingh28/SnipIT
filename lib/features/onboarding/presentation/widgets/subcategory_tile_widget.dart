// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:snipit/core/constants/app_colors.dart';
import 'package:snipit/core/constants/app_text_styles.dart';
import 'package:snipit/core/utils/custom_spacers.dart';
import 'package:snipit/core/utils/screen_utils.dart';
import 'package:snipit/features/onboarding/data/model/category_model.dart';
import 'package:snipit/features/onboarding/data/model/subcategory_model.dart';
import 'package:snipit/features/onboarding/presentation/bloc/subcategory/subcategory_bloc.dart';
import 'package:snipit/ui/injection_container.dart';

class SubcategoryTileWidget extends StatefulWidget {
  SubcategoryModel category;
  bool isSelected;
  final Function(bool) onTap;

  SubcategoryTileWidget(
      {super.key,
      required this.category,
      required this.isSelected,
      required this.onTap});

  @override
  State<SubcategoryTileWidget> createState() => _SubcategoryTileWidgetState();
}

class _SubcategoryTileWidgetState extends State<SubcategoryTileWidget> {
  SubcategoryBloc bloc = sl<SubcategoryBloc>();
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_isSelected) {
          _isSelected = false;
          widget.onTap(_isSelected);
        } else {
          _isSelected = true;
          widget.onTap(_isSelected);
        }
      },
      child: SizedBox(
        width: 80.w,
        height: 101.h,
        child: Column(
          children: [
            !_isSelected
                ? CircleAvatar(
                    radius: 31,
                    child: Image.network(
                      widget.category.image,
                    ),
                  )
                : CircleAvatar(
                    radius: 31,
                    child: Stack(
                      children: [
                        Image.network(
                          widget.category.image,
                        ),
                        CircleAvatar(
                          radius: 31,
                          backgroundColor: AppColors.primary.withOpacity(1),
                          child: const Center(
                            child: Icon(
                              Icons.check,
                              color: AppColors.white,
                              size: 35,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
            CustomSpacers.height4,
            Text(
              widget.category.name,
              style: AppTextStyles.textStyles_MN_30_400_black
                  .copyWith(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
