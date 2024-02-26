import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:snipit/features/onboarding/domain/entities/submit_email_entity.dart';
import 'package:snipit/features/onboarding/domain/entities/verify-otp-event.dart';
import 'package:snipit/features/onboarding/presentation/bloc/forgot_password_bloc/forgot_password_event.dart';
import 'package:snipit/features/onboarding/presentation/bloc/forgot_password_bloc/forgot_password_state.dart';
import 'package:snipit/route/app_pages.dart';
import 'package:snipit/route/custom_navigator.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/custom_spacers.dart';
import '../../../../ui/injection_container.dart';
import '../../../../ui/molecules/custom_button.dart';
import '../bloc/forgot_password_bloc/forgot_password_bloc.dart';
import '../widgets/footer_otp_widget.dart';

class VerifyOtpScreen extends StatefulWidget {
  VerifyOtpScreen({Key? key}) : super(key: key);

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {

  OtpFieldController otpController = OtpFieldController();
  String otp = '';
  final _bloc=sl<ForgotPasswordBloc>();
  String? _email = '';

  @override
  void didChangeDependencies() {
    final Map<String, dynamic> args =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    _email = args["email"];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>_bloc,
      child: BlocListener<ForgotPasswordBloc,ForgotPasswordState>(
        listener: (context,state){
          if(state is OtpVerifiedState){
            final Map<String, dynamic> args =
            ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
            CustomNavigator.pushTo(context,AppPages.createNewPassword,arguments: {"email":_email,"otp":otp,"fromLogin":args["fromLogin"]});
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
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
                strButtonText: "Continue",
                buttonAction: () {
                  if(otp.length==6){
                    VerifyOtpEntity entity=VerifyOtpEntity(email: _email!, otp: otp);
                  _bloc.add(OtpSubmitEvent(entity: entity));
                  }
                },
                textStyle: AppTextStyles.textStyles_MN_30_600_black
                    .copyWith(fontSize: 16),
              ),
              CustomSpacers.height56,
              GestureDetector(
                onTap: (){
                  SubmitEmailEntity entity=SubmitEmailEntity(email: _email!);
                  _bloc.add(ResendOtpEvent(entity: entity));
                },
                child: FooterOtpWidget("Don't see your email? ", "Resend"),
              ),
              CustomSpacers.height15,
              GestureDetector(
                onTap: (){
                  CustomNavigator.pushTo(context, AppPages.login);
                },
                child: FooterOtpWidget("Already have an account? ", "Login"),
              ),
              CustomSpacers.height15,
              FooterOtpWidget("Start registration over? ", "Join"),
              CustomSpacers.height15,
              FooterOtpWidget("Having trouble? ", "hello@snipit.org"),
            ],
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
