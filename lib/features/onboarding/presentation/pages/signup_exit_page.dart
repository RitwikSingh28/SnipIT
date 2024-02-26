import 'package:flutter/material.dart';
import 'package:snipit/core/constants/app_text_styles.dart';
import 'package:snipit/core/utils/custom_spacers.dart';
import 'package:snipit/features/onboarding/presentation/widgets/footer_widget.dart';
import 'package:snipit/route/app_pages.dart';
import 'package:snipit/route/custom_navigator.dart';
import 'package:snipit/ui/molecules/custom_button.dart';

import '../../../../core/constants/app_colors.dart';

class SignUpExitPage extends StatelessWidget {
  const SignUpExitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            CustomSpacers.height80,
            _buidHeroText(),
            const Spacer(),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    strButtonText: 'Continue',
                    buttonAction: () {
                      CustomNavigator.pushTo(context, AppPages.category);
                    },
                    buttonType: ButtonType.OUTLINED,
                  ),
                ),
                CustomSpacers.height10,
                FooterWidget(buttonAction: (){
                  // CustomNavigator.pushTo(context, AppPages.category);
                }, clickText: "Login", text: "Already have an account? " , fontSize: 14,),
                CustomSpacers.height38,
               
              ],
            )
          ],
        ),
      ),
    );
  }

  _buidHeroText() {
    return RichText(
        text: const TextSpan(children: [
      TextSpan(
        text: "Time to start curating your ",
        style: AppTextStyles.textStyles_MN_30_400_black,
      ),
      TextSpan(
        text: "content",
        style: AppTextStyles.textStyles_MN_30_600_black,
      )
    ]));
  }

  
  
}
