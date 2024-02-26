import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snipit/core/utils/screen_utils.dart';
import 'package:snipit/route/app_pages.dart';
import 'package:snipit/route/custom_navigator.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_data.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/custom_spacers.dart';
import '../pages/myfeed_page.dart';

class Header extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? actionCallback;
  final TextEditingController searchController;
  final List<String> tabBarItems;
  final void Function(int) onTabBarItemTap;
  final int tabBarSelectedIndex;
  // final ScrollController scrollController;

  const Header({
    super.key,
    required this.title,
    required this.searchController,
    required this.tabBarItems,
    required this.onTabBarItemTap,
    required this.tabBarSelectedIndex,
    // required this.scrollController,
    this.actionText,
    this.actionCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CustomTextField(
          // controller: _searchController,
          //   hint: 'Search',
          //   suffix: Icon(Icons.search),
          //   borderRadius: 100,
          //   fillColor: AppColors.grey,
          // ),
          Container(
            height: 40.h,
            width: 364.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Color.fromARGB(255, 213, 213, 213),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
              child: InkWell(
                onTap: (){
                  CustomNavigator.pushTo(context, AppPages.searchNews);
                },
                child: TextFormField(
                  enabled: false,
                  controller: searchController,
                  decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(fontSize: 14),
                      suffixIcon: Icon(
                        Icons.search,
                        size: 18,
                      ),
                      suffixIconColor: AppColors.grey,
                      border: InputBorder.none),
                ),
              ),
            ),
          ),
          CustomSpacers.height26,
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.textStyles_MN_30_600_black
                      .copyWith(fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (actionText != null && actionCallback != null)
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text.rich(
                    TextSpan(
                      text: actionText,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF3A3A3A),
                        overflow: TextOverflow.ellipsis,
                        fontFamily: AppFontFamily.maisonNeue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = actionCallback,
                    ),
                  ),
                ),
            ],
          ),
          CustomSpacers.height15,
          SizedBox(
            height: 30.h,
            width: 500.w,
            child: ListView.builder(
                // controller: scrollController,
                itemCount: tabBarItems.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return NewsCategoryHeadlineWidget(
                    title: tabBarItems[index],
                    selectedIndex: tabBarSelectedIndex,
                    index: index,
                    isSelected: tabBarSelectedIndex == index,
                    ontap: onTabBarItemTap,
                  );
                }),
          ),
          Container(
            height: 1,
            color: Color.fromARGB(255, 219, 219, 219),
          ),
        ],
      ),
    );
  }
}
