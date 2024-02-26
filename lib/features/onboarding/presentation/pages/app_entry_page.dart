// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:snipit/core/constants/app_colors.dart';
import 'package:snipit/core/constants/app_icons.dart';
// ignore: unused_import
import 'package:snipit/core/constants/app_text_styles.dart';
import 'package:snipit/core/utils/custom_spacers.dart';
import 'package:snipit/features/onboarding/presentation/widgets/footer_widget.dart';
import 'package:snipit/route/app_pages.dart';
import 'package:snipit/route/custom_navigator.dart';
import 'package:snipit/ui/molecules/custom_button.dart';

class AppEntryPage extends StatefulWidget {
  const AppEntryPage({super.key});

  @override
  State<AppEntryPage> createState() => _AppEntryPageState();
}

class _AppEntryPageState extends State<AppEntryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primary,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(children: [
            CustomSpacers.height160,
            CustomSpacers.height120,
            SvgPicture.asset(
              AppIcons.app_icon,
              color: AppColors.white,
            ),
            CustomSpacers.height160,
            CustomSpacers.height52,
            //====================Sign Up Button ============================================================
            _buildSignUpButton(),
            CustomSpacers.height15,
            //======================Login Button==========================================================
            _buildLoginButton(),
            CustomSpacers.height15,
            _buildGuestReferralCode(),
            CustomSpacers.height40,
            FooterWidget(
                buttonAction: () {},
                clickText: "Terms & Conditions",
                text: 'By using SnipIt, you agree to our ' , fontSize: 12,)
          ]),
        ));
  }

  _buildSignUpButton() => CustomButton(
        strButtonText: "Sign Up",
        buttonAction: () {
          CustomNavigator.pushTo(context, AppPages.onBoarding);
        },
        bgColor: AppColors.white,
        dCornerRadius: 5,
        textStyle: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.black),
      );
  _buildLoginButton() => CustomButton(
        strButtonText: "Log In",
        buttonAction: () {},
        buttonType: ButtonType.OUTLINED,
        bgColor: AppColors.white,
        dCornerRadius: 5,
        textStyle: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.black),
      );
  _buildGuestReferralCode() => const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Continue as Guest",
            style:
                TextStyle(fontWeight: FontWeight.w600, color: AppColors.black),
          ),
          Text(
            "Enter Referral Code",
            style:
                TextStyle(fontWeight: FontWeight.w600, color: AppColors.black),
          )
        ],
      );
}
