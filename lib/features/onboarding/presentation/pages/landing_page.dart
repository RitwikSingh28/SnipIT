import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snipit/core/constants/app_colors.dart';
import 'package:snipit/core/helpers/user_helpers.dart';
import 'package:snipit/core/utils/custom_spacers.dart';
import 'package:snipit/ui/molecules/custom_button.dart';
import 'package:snipit/ui/molecules/custom_scaffold.dart';

import '../../../../core/constants/app_text_styles.dart';
import '../../../../route/app_pages.dart';
import '../../../../route/custom_navigator.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    UserHelpers.setFirstTimeDone();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Stack(
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 100),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Perfect, let’s get stuck in to the ',
                      style: AppTextStyles.textStyles_MN_30_400_black,
                    ),
                    TextSpan(
                      text: 'fun stuff',
                      style: AppTextStyles.textStyles_MN_30_600_black,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomButton(
                  strButtonText: 'Continue',
                  buttonAction: () {
                    CustomNavigator.pushTo(context, AppPages.category);
                  },
                  textStyle: AppTextStyles.textStyles_MN_30_600_black
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                CustomSpacers.height20,
                Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: AppColors.black,
                      fontFamily: AppFontFamily.maisonNeue,
                    ),
                    children: [
                      TextSpan(text: 'Already have an account? '),
                      TextSpan(
                        text: 'Log in',
                        style: TextStyle(decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () =>
                              CustomNavigator.pushTo(context, AppPages.login),
                      ),
                    ],
                  ),
                ),
                CustomSpacers.height30,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
