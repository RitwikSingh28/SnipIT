import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:snipit/core/constants/app_colors.dart';
import 'package:snipit/core/utils/screen_utils.dart';

class NewsShimmer extends StatelessWidget {
  const NewsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 322.h,
      width: 872.w,
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return const NewsTileShimmer();
          }),
    );
  }
}

class NewsTileShimmer extends StatelessWidget {
  const NewsTileShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.Secondary,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.shimmerBaseColor,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 322.h,
        width: 284.w,
      ),
    );
  }
}
