import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:snipit/core/constants/app_colors.dart';
import 'package:snipit/core/constants/app_text_styles.dart';
import 'package:snipit/core/helpers/user_helpers.dart';
import 'package:snipit/core/utils/custom_spacers.dart';
import 'package:snipit/features/onboarding/domain/entities/verify-otp-event.dart';
import 'package:snipit/features/onboarding/presentation/bloc/signup/signup_bloc.dart';
import 'package:snipit/route/app_pages.dart';
import 'package:snipit/route/custom_navigator.dart';
import 'package:snipit/ui/injection_container.dart';
import 'package:snipit/ui/molecules/custom_button.dart';

import '../widgets/footer_otp_widget.dart';

class VerifyOtpPage extends StatefulWidget {
  const VerifyOtpPage({
    super.key,
  });

  @override
  State<VerifyOtpPage> createState() => VerifyOtpPageState();
}

class VerifyOtpPageState extends State<VerifyOtpPage> {
  TextEditingController postcodeController = TextEditingController();
  final bloc = sl<SignupBloc>();
  String? _email = '';
  OtpFieldController otpController = OtpFieldController();
  String otp = '';

  @override
  void didChangeDependencies() {
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    _email = args["email"];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Secondary,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocProvider(
          create: (context) => bloc,
          child: BlocListener<SignupBloc, SignupState>(
            listener: (context, state) {
              if (state is OtpVerifiedState) {
                if (state.response.status) {
                  UserHelpers.setAuthToken(state.response.token);
                  // CustomNavigator.pushTo(context, AppPages.signUpExitPage);
                  CustomNavigator.pushTo(context, AppPages.editProfile,
                      arguments: {"email": _email});
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: BlocBuilder<SignupBloc, SignupState>(
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomSpacers.height80,
                      RichText(
                        text: const TextSpan(children: [
                          TextSpan(
                              text: "Please verify your email address",
                              style: AppTextStyles.textStyles_MN_30_400_black),
                        ]),
                      ),
                      CustomSpacers.height20,
                      const Text(
                          'Please enter the 6 digit code we have sent via email to continue'),
                      CustomSpacers.height40,
                      _buildForm(),
                      CustomSpacers.height36,
                      CustomButton(
                        strButtonText: "Confirm Account",
                        buttonAction: () {
                          bloc.add(VerifyOtpEvent(
                              entity:
                                  VerifyOtpEntity(email: _email!, otp: otp)));
                        },
                        textStyle: AppTextStyles.textStyles_MN_30_600_black
                            .copyWith(fontSize: 16),
                      ),
                      CustomSpacers.height56,
                      FooterOtpWidget("Don't see your email? ", "Resend"),
                      CustomSpacers.height15,
                      FooterOtpWidget("Already have an account? ", "Login"),
                      CustomSpacers.height15,
                      FooterOtpWidget("Start registration over? ", "Join"),
                      CustomSpacers.height15,
                      FooterOtpWidget("Having trouble? ", "hello@snipit.org"),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildForm() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enter Code',
            style: AppTextStyles.textStyles_MN_30_400_black
                .copyWith(fontSize: 14, fontWeight: FontWeight.w300),
          ),
          Center(
            child: OTPTextField(
                controller: otpController,
                length: 6,
                otpFieldStyle: OtpFieldStyle(
                  borderColor: AppColors.primary,
                ),
                width: MediaQuery.of(context).size.width,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldWidth: 40,
                fieldStyle: FieldStyle.underline,
                outlineBorderRadius: 15,
                style:
                    const TextStyle(fontSize: 17, decorationColor: AppColors.primary),
                onChanged: (pin) {
                  otp = pin;
                },
                onCompleted: (pin) {
                  otp = pin;
                }),
          ),
        ],
      );


}
