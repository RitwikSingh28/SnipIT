import 'package:flutter/material.dart';
import 'package:snipit/core/constants/app_text_styles.dart';
import 'package:snipit/core/utils/custom_spacers.dart';
import 'package:snipit/route/app_pages.dart';
import 'package:snipit/route/custom_navigator.dart';
import 'package:snipit/ui/molecules/custom_button.dart';
import 'package:snipit/ui/molecules/custom_scaffold.dart';

class SignUpLandingPage extends StatelessWidget {
  const SignUpLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<dynamic, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>;

    return CustomScaffold(
      body: Column(
        children: [
          Spacer(),
          Text(
            'Ready to see your stories?',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,
              fontFamily: AppFontFamily.maisonNeue,
            ),
          ),
          CustomSpacers.height10,
          Text(
            'We just need a few details to get you started.',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: AppFontFamily.maisonNeue,
            ),
          ),
          Spacer(),
          CustomButton(
            strButtonText: 'Sign up',
            buttonAction: () {
              CustomNavigator.pushTo(context, AppPages.signupInitialPage,
                  arguments: args);
            },
            textStyle:
                AppTextStyles.textStyles_MN_30_600_black.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
