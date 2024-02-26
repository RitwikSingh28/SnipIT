import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:snipit/core/constants/app_colors.dart';
import 'package:snipit/core/constants/app_icons.dart';
import 'package:snipit/core/constants/app_images.dart';
import 'package:snipit/core/constants/app_text_styles.dart';
import 'package:snipit/core/helpers/authHelper.dart';
import 'package:snipit/core/helpers/ui_helpers.dart';
import 'package:snipit/core/helpers/user_helpers.dart';
import 'package:snipit/core/utils/custom_spacers.dart';
import 'package:snipit/features/onboarding/data/model/login_option.dart';
import 'package:snipit/features/onboarding/domain/entities/login_via_email_entity.dart';
import 'package:snipit/features/onboarding/presentation/bloc/login/login_bloc.dart';
import 'package:snipit/ui/injection_container.dart';
import 'package:snipit/ui/molecules/custom_button.dart';
import 'package:snipit/ui/molecules/custom_text_field.dart';
import '../../../../core/validators.dart';
import '../../../../route/app_pages.dart';
import '../../../../route/custom_navigator.dart';
import '../../../../ui/molecules/custom_scaffold.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _bloc = sl<LoginBloc>();

  final _scrollController =
      ScrollController(initialScrollOffset: UiHelpers.keyboardHeight);
  bool _isKeyboardVisible = false;
  bool _isPasswordVisible = false;
  final List<LoginOption> _loginOptions = [
    LoginOption(title: 'Apple', appIcon: AppIcons.apple_icon, onTap: () {}),
    LoginOption(
        title: 'Google',
        appIcon: AppIcons.google_icon,
        onTap: () {
          AuthHelper().signInWithGoogle();
        }),
    LoginOption(title: 'Twitter', appIcon: AppIcons.twitter_icon, onTap: () {}),
    LoginOption(
        title: 'Facebook', appIcon: AppIcons.facebook_icon, onTap: () {})
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.addListener(() {
        final bool newValue = UiHelpers.keyboardHeight > 0;
        if (newValue != _isKeyboardVisible) {
          _isKeyboardVisible = newValue;
          if (_isKeyboardVisible && _scrollController.hasClients) {
            _scrollController
                .jumpTo(_scrollController.position.maxScrollExtent);
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _formKey.currentState?.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  _signInViaGoogle() {
    AuthHelper().signInWithGoogle().then((value) async {
      if (value != null) {
        var token = await value.getIdToken();
        print(value);
        if (token != null) {
          // _bloc.add(RegisterViaOAuthEvent(
          //     entity: SocialAuthEntity(
          //         provider: "google",
          //         provider_id: token,
          //         categories: args['selectedCategories'],
          //         subcategories: args['selectedSubcategories'])));
        }

        // User is signed in.
      } else {
        // Sign-in failed.
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  BlocProvider<LoginBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginViaEmailSuccessState) {
            if (state.userResponseModel != null) {
              var userResult = state.userResponseModel;
              UserHelpers.setUserDetails(state.userResponseModel.user);
              UserHelpers.setAuthToken(state.userResponseModel.token);
              CustomNavigator.pushTo(context, AppPages.loading);
            }
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: UiHelpers.hideKeyboard,
              child: CustomScaffold(
                body: SizedBox(
                  height: double.infinity,
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 40),
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                text: 'Enter your details to ',
                                style: AppTextStyles.textStyles_MN_30_400_black,
                              ),
                              TextSpan(
                                text: 'sign in.',
                                style: AppTextStyles.textStyles_MN_30_600_black,
                              ),
                            ])),
                            CustomSpacers.height40,
                            Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomTextField.primary(
                                    controller: _emailController,
                                    validator: Validators.email,
                                    hint: 'Email address',
                                    keyboardType: TextInputType.emailAddress,
                                    maxLines: 1,
                                    borderRadius: 30,
                                  ),
                                  CustomSpacers.height15,
                                  CustomTextField.primary(
                                    controller: _passwordController,
                                    validator: Validators.password,
                                    hint: 'Password',
                                    keyboardType: TextInputType.text,
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
                                  CustomSpacers.height15,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            CustomNavigator.pushTo(context,
                                                AppPages.forgotPAssword,
                                                arguments: {"fromLogin": true});
                                          },
                                          child: Text("Forgot Password?",
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.w600))),
                                    ],
                                  ),
                                  CustomSpacers.height8,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Divider(
                                            thickness: 1,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("or sign in with"),
                                        ),
                                        Flexible(
                                          child: Divider(
                                            thickness: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 16),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: List.generate(
                                            _loginOptions.length,
                                            (index) => InkWell(
                                                  onTap: () {
                                                    _loginOptions[index]
                                                        .onTap();
                                                  },
                                                  child: _buildSocialIcon(
                                                      _loginOptions[index]),
                                                ))),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 150),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: AppColors.Secondary,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomButton(
                                //_submitForm
                                strButtonText: 'Sign in',
                                buttonAction: () {
                                  print("token here");
                                  print(UserHelpers.getAuthToken());
                                  if (_formKey.currentState!.validate()) {
                                    _bloc.add(LoginViaEmailEvent(
                                        entity: EmailLoginEntity(
                                            email: _emailController.text.trim(),
                                            password:
                                                _passwordController.text)));
                                  }
                                },

                                textStyle: AppTextStyles
                                    .textStyles_MN_30_600_black
                                    .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
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
                                    TextSpan(text: 'Don\'t have an account? '),
                                    TextSpan(
                                      text: 'Sign up',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => CustomNavigator.pushTo(
                                              context,
                                              AppPages.category,
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _buildSocialIcon(LoginOption option) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(width: 0.3)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SvgPicture.asset(option.appIcon, height: 34),
      ),
    );
  }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate();
    if (isValid == null || !isValid) {
      return;
    }
    CustomNavigator.pushTo(context, AppPages.loading);
  }
}
