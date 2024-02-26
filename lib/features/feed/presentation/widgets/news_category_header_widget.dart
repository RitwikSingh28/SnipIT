import 'package:flutter/material.dart';
import 'package:snipit/core/constants/app_colors.dart';
import 'package:snipit/core/constants/app_text_styles.dart';
import 'package:snipit/core/utils/screen_utils.dart';

class NewsCategoryHeadlineWidget extends StatefulWidget {
  int selectedIndex;
  String title;
  int index;
  Function(int) ontap;
  NewsCategoryHeadlineWidget(
      {super.key,
      required this.selectedIndex,
      required this.title,
      required this.index , required this.ontap});

  @override
  State<NewsCategoryHeadlineWidget> createState() =>
      _NewsCategoryHeadlineWidgetState();
}

class _NewsCategoryHeadlineWidgetState
    extends State<NewsCategoryHeadlineWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print(widget.index);
        widget.ontap(widget.index);
      },
      child: Container(
          height: 40.h,
          width: 95.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: AppTextStyles.textStyles_MN_30_600_black
                    .copyWith(fontWeight: FontWeight.w700, fontSize: 14),
              ),
              widget.selectedIndex == widget.index
                  ? Container(
                      height: 4,
                      color: AppColors.primary,
                    )
                  : Container(),
            ],
          )),
    );
  }
}
