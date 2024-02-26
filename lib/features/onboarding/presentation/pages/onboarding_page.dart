import 'package:flutter/material.dart';
import 'package:snipit/core/constants/app_colors.dart';
import 'package:snipit/core/constants/app_data.dart';
import 'package:snipit/core/constants/app_text_styles.dart';
import 'package:snipit/core/utils/custom_spacers.dart';
import 'package:snipit/core/utils/screen_utils.dart';
import 'package:snipit/route/app_pages.dart';
import 'package:snipit/route/custom_navigator.dart';
import 'package:snipit/ui/molecules/custom_button.dart';

import '../../../../ui/molecules/custom_scaffold.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      // backgroundColor: AppColors.Secondary,
      // appBar: AppBar(
      //   backgroundColor: AppColors.Secondary,
      //   elevation: 0,
      //   leading: GestureDetector(
      //     onTap: () {
      //       CustomNavigator.pop(context);
      //     },
      //     child: Icon(
      //       Icons.arrow_back,
      //       color: AppColors.black,
      //       size: 24,
      //     ),
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomSpacers.height70,
            _buildTextSlider(),
            // CustomSpacers.height10,
            _currentPage == 2
                ? _buildContinueButton()
                : CustomButton(
                    strButtonText: "Continue",
                    buttonAction: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    textStyle: AppTextStyles.textStyles_MN_30_600_black
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
            CustomSpacers.height30,
            _buildPointSlider(),
          ],
        ),
      ),
    );
  }

  _buildContinueButton() => CustomButton(
        strButtonText: 'Continue',
        buttonAction: () {
          CustomNavigator.pushTo(context, AppPages.landing);
        },
        textStyle: AppTextStyles.textStyles_MN_30_600_black
            .copyWith(fontSize: 16, fontWeight: FontWeight.w700),
      );

  _buildTextSlider() => SizedBox(
        height: MediaQuery.of(context).size.height * 0.60,
        width: MediaQuery.of(context).size.width * 0.79,
        child: PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          itemCount: AppData.onboardingPages.length,
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
          itemBuilder: (BuildContext context, int index) {
            return AppData.onboardingPages[index];
          },
        ),
      );

  _buildPointSlider() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: AppData.onboardingPages.map((item) {
          int index = AppData.onboardingPages.indexOf(item);
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 15.w,
            height: 21..h,
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black),
                color: _currentPage == index
                    ? AppColors.blueButton
                    : AppColors.Secondary),
          );
        }).toList(),
      );
}

//===================================ONBOARDING ITEMS =================================

// ignore: must_be_immutable
class OnboardingItem extends StatelessWidget {
  final String mainDescription;
  final String colorDescription;
  bool switchDescription;
  String image;
  OnboardingItem(
      {super.key,
      required this.mainDescription,
      required this.colorDescription,
      required this.switchDescription,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(image),
        CustomSpacers.height120,
        switchDescription
            ? RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      text: "Experience ",
                      style: AppTextStyles.textStyles_MN_30_400_black
                          .copyWith(fontSize: 24)),
                  TextSpan(
                      text: colorDescription,
                      style: AppTextStyles.textStyles_MN_30_600_black
                          .copyWith(fontSize: 24)),
                  TextSpan(
                      text: mainDescription,
                      style: AppTextStyles.textStyles_MN_30_400_black
                          .copyWith(fontSize: 24)),
                ]),
              )
            : RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      text: mainDescription,
                      style: AppTextStyles.textStyles_MN_30_400_black
                          .copyWith(fontSize: 24)),
                  TextSpan(
                      text: colorDescription,
                      style: AppTextStyles.textStyles_MN_30_600_black
                          .copyWith(fontSize: 24))
                ]),
              ),
      ],
    );
  }
}
