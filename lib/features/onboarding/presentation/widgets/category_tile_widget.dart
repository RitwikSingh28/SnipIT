// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:snipit/core/constants/app_colors.dart';
import 'package:snipit/core/constants/app_text_styles.dart';
import 'package:snipit/core/utils/custom_spacers.dart';
import 'package:snipit/core/utils/screen_utils.dart';
import 'package:snipit/features/onboarding/data/model/category_model.dart';
import 'package:snipit/features/onboarding/presentation/bloc/category/category_bloc.dart';
import 'package:snipit/ui/injection_container.dart';

class CategoryTileWidget extends StatefulWidget {
  dynamic category;
  bool isSelected;
  final Function(bool) onTap;

  CategoryTileWidget(
      {super.key,
      required this.category,
      required this.isSelected,
      required this.onTap});

  @override
  State<CategoryTileWidget> createState() => _CategoryTileWidgetState();
}

class _CategoryTileWidgetState extends State<CategoryTileWidget> {
  bool _isSelected = false;
  @override
  void initState() {
    _isSelected = widget.isSelected;
    super.initState();
  }

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
        height: 100.h,
        child: Column(
          children: [
            !_isSelected
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.height * 0.06,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        imageUrl: widget.category.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height * 0.065,
                    width: MediaQuery.of(context).size.height * 0.065,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            imageUrl: widget.category.image,
                            fit: BoxFit.cover,
                            height: 66,
                            width: 66,
                          ),
                        ),
                        Container(
                          height: 66,
                          width: 66,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary.withOpacity(0.8)),
                          child: const Center(
                            child: Icon(
                              Icons.check,
                              color: AppColors.white,
                              size: 35,
                            ),
                          ),
                        ),
                      ],
                    )),
            // CircleAvatar(
            //     radius: 31,
            //     child: Stack(
            //       children: [
            //         Image.network(
            //           widget.category.image,
            //         ),
            //         CircleAvatar(
            //           radius: 31,
            //           backgroundColor: AppColors.primary.withOpacity(1),
            //           child: const Center(
            //             child: Icon(
            //               Icons.check,
            //               color: AppColors.white,
            //               size: 35,
            //             ),
            //           ),
            //         )
            //       ],
            //     ),
            //   ),

            CustomSpacers.height4,
            Text(
              widget.category.name,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.textStyles_MN_30_400_black
                  .copyWith(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
