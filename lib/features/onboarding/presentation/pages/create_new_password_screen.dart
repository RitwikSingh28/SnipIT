import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snipit/core/helpers/user_helpers.dart';
import 'package:snipit/core/utils/custom_spacers.dart';
import 'package:snipit/features/onboarding/domain/entities/change_password_entity.dart';
import 'package:snipit/features/onboarding/presentation/bloc/forgot_password_bloc/forgot_password_event.dart';
import 'package:snipit/features/onboarding/presentation/bloc/forgot_password_bloc/forgot_password_state.dart';
import 'package:snipit/route/app_pages.dart';
import 'package:snipit/route/custom_navigator.dart';
import 'package:snipit/ui/molecules/custom_scaffold.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/validators.dart';
import '../../../../ui/injection_container.dart';
import '../../../../ui/molecules/custom_button.dart';
import '../../../../ui/molecules/custom_text_field.dart';
import '../bloc/forgot_password_bloc/forgot_password_bloc.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _bloc=sl<ForgotPasswordBloc>();
  String? _email='';
  String? _otp='';
  bool _isPasswordVisible = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    final Map<String, dynamic> args =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    _email = args["email"];
    _otp=args["otp"];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: BlocProvider(
          create: (context)=>_bloc,
          child: Form(
            key: _formKey,
            child: BlocListener<ForgotPasswordBloc,ForgotPasswordState>(
              listener: (context,state){
                if(state is PasswordChangeSuccessState){
                  final Map<String, dynamic> args =
                  ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
                  if(args["fromLogin"]){
                    CustomNavigator.pushNamedAndRemoveUntil(context, AppPages.login);
                  }
                  else{
                    UserHelpers.logout();
                    CustomNavigator.pushNamedAndRemoveUntil(context, AppPages.login);
                  }
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField.primary(
                    controller: _passwordController,
                    validator: Validators.password,
                    hint: 'Password',
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 1,
                    borderRadius: 30,
                    obscureText: !_isPasswordVisible,
                    suffix: GestureDetector(
                      onTap: () => setState(() =>
                      _isPasswordVisible =
                      !_isPasswordVisible),
                      child: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Color.fromARGB(126, 0, 0, 0),
                        size: 20,
                      ),
                    ),
                  ),
                  CustomSpacers.height16,
                  CustomTextField.primary(
                    obscureText: true,
                    controller: _confirmPasswordController,
                    validator:(value)=>Validators.confirmPassword(
                        _passwordController.text,value??""),
                    hint: 'Confirm Password',
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 1,
                    borderRadius: 30,
                  ),
                  CustomSpacers.height20,
                  CustomButton(
                    //_submitForm
                    strButtonText: 'Change Password',
                    buttonAction: () {
                      if (_formKey.currentState!.validate()) {
                        ChangePasswordEntity entity=ChangePasswordEntity(email: _email!, password: _passwordController.text, confirmPassword: _confirmPasswordController.text, otp: _otp!);
                        _bloc.add(CreateNewPasswordEvent(entity: entity));
                      }
                    },

                    textStyle: AppTextStyles
                        .textStyles_MN_30_600_black
                        .copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
