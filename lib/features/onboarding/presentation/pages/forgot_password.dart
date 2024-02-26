import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:snipit/core/network/network_info.dart';
import 'package:snipit/features/onboarding/data/datasource/onboarding_data_source.dart';
import 'package:snipit/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:snipit/features/onboarding/domain/entities/submit_email_entity.dart';
import 'package:snipit/features/onboarding/domain/usecases/check_email_use_case.dart';
import 'package:snipit/features/onboarding/domain/usecases/check_otp_use_case.dart';
import 'package:snipit/features/onboarding/domain/usecases/create_password_usecase.dart';
import 'package:snipit/features/onboarding/presentation/bloc/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:snipit/features/onboarding/presentation/bloc/forgot_password_bloc/forgot_password_state.dart';
import 'package:snipit/route/app_pages.dart';
import 'package:snipit/route/custom_navigator.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/custom_spacers.dart';
import '../../../../core/validators.dart';
import '../../../../ui/injection_container.dart';
import '../../../../ui/molecules/custom_button.dart';
import '../../../../ui/molecules/custom_scaffold.dart';
import '../../../../ui/molecules/custom_text_field.dart';
import '../bloc/forgot_password_bloc/forgot_password_event.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _bloc = sl<ForgotPasswordBloc>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: CustomScaffold(
        appBarTitle: Text("Forgot Password"),
        body: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
          listener: (context, state) {
            if (state is EmailRegisteredState) {
              final Map<String, dynamic> args = ModalRoute.of(context)
                  ?.settings
                  .arguments as Map<String, dynamic>;
              CustomNavigator.pushTo(context, AppPages.forgotPAsswordVerifyOtp,
                  arguments: {
                    "email": _emailController.text,
                    "fromLogin": args["fromLogin"]
                  });
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Please enter your registered email.',
                style: AppTextStyles.textStyles_MN_30_400_black
                    .copyWith(fontSize: 22),
              ),
              CustomSpacers.height28,
              Form(
                key: _formKey,
                child: CustomTextField.primary(
                  controller: _emailController,
                  validator: Validators.email,
                  hint: 'Email address',
                  keyboardType: TextInputType.emailAddress,
                  maxLines: 1,
                  borderRadius: 30,
                ),
              ),
              Spacer(),
              CustomButton(
                //_submitForm
                strButtonText: 'Continue',
                buttonAction: () {
                  if (_formKey.currentState!.validate()) {
                    _bloc.add(EmailSubmitEvent(
                        entity:
                            SubmitEmailEntity(email: _emailController.text)));
                  }
                },

                textStyle: AppTextStyles.textStyles_MN_30_600_black
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
      ),
    );
  }
}
