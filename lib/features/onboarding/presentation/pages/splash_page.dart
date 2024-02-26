import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:snipit/core/constants/app_icons.dart';
import 'package:snipit/core/constants/app_text_styles.dart';
import 'package:snipit/core/helpers/user_helpers.dart';
import 'package:snipit/core/utils/custom_spacers.dart';
import 'package:snipit/features/onboarding/data/model/userModel.dart';
import 'package:snipit/route/app_pages.dart';
import 'package:snipit/route/custom_navigator.dart';
import 'package:snipit/ui/molecules/custom_button.dart';
import '../../../../ui/molecules/custom_scaffold.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void routeToPage(BuildContext context) async {
    var user = await UserHelpers.getUserDetails();
    var isFirstTimeDone = UserHelpers.getIsFirstTimeDone();
    if (user != null && user != false
        //  && user.isProfileComplete
        ) {
      var token = UserHelpers.getAuthToken();

      if (token != null) {
        if (user.isProfileComplete == false) {
          CustomNavigator.pushReplace(context, AppPages.editProfile,
              arguments: {"email": user?.email});
        } else {
          CustomNavigator.pushReplace(context, AppPages.dashboard);
        }
      }
    } else {
      if (isFirstTimeDone) {
        CustomNavigator.pushReplace(context, AppPages.login);
      } else {
        CustomNavigator.pushReplace(context, AppPages.onBoarding);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      routeToPage(context);
    });
    return CustomScaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppIcons.app_icon),
                  CustomSpacers.height18,
                  Text(
                    'TL;DR ARTICLES CURATED BY YOU',
                    style: AppTextStyles.textStyles_PTSans_16_400_Secondary
                        .copyWith(fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                  CustomSpacers.height120,
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: CustomButton(
                strButtonText: 'Get Started',
                buttonAction: () {
                  CustomNavigator.pushReplace(context, AppPages.onBoarding);
                },
                textStyle: AppTextStyles.textStyles_MN_30_600_black
                    .copyWith(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
