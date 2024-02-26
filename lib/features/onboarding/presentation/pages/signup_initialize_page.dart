// ignore_for_file: camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:snipit/core/constants/app_colors.dart';
import 'package:snipit/core/constants/app_icons.dart';
import 'package:snipit/core/constants/app_text_styles.dart';
import 'package:snipit/core/helpers/authHelper.dart';
import 'package:snipit/core/helpers/user_helpers.dart';
import 'package:snipit/core/utils/custom_spacers.dart';
import 'package:snipit/core/utils/screen_utils.dart';
import 'package:snipit/features/onboarding/domain/entities/social_auth_entity.dart';
import 'package:snipit/features/onboarding/presentation/bloc/signup/signup_bloc.dart';
import 'package:snipit/features/onboarding/presentation/widgets/footer_widget.dart';
import 'package:snipit/route/app_pages.dart';
import 'package:snipit/route/custom_navigator.dart';
import 'package:snipit/ui/injection_container.dart';

import '../../../../ui/molecules/custom_scaffold.dart';

class signupInitialPage extends StatefulWidget {
  const signupInitialPage({super.key});

  @override
  State<signupInitialPage> createState() => _signupInitialPageState();
}

class _signupInitialPageState extends State<signupInitialPage> {
  final _blocReference = sl<SignupBloc>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<dynamic, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>;

    return CustomScaffold(
      body: BlocProvider(
        create: (context) => _blocReference,
        child: BlocListener<SignupBloc, SignupState>(
          listener: (context, state) {
            if (state is SocialAuthSuccessState) {
              CustomNavigator.pushTo(context, AppPages.login);
              UserHelpers.setAuthToken(state.model.token);
              // CustomNavigator.pushTo(context, AppPages.signUpExitPage);
              if (state.model.user!.isProfileComplete) {
                UserHelpers.setUserDetails(state.model.user!);
                CustomNavigator.pushTo(
                  context,
                  AppPages.loading,
                );
              } else {
                CustomNavigator.pushTo(context, AppPages.editProfile,
                    arguments: {"email": state.model.user?.email});
              }
            }
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Column(
                children: [
                  CustomSpacers.height80,
                  CustomSpacers.height30,
                  _buildBody(args),
                  CustomSpacers.height120,
                  FooterWidget(
                    buttonAction: () {
                      CustomNavigator.pushTo(context, AppPages.login);
                    },
                    clickText: "Login",
                    text: "Already have an account? ",
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildBody(args) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Sign up using one of the following:',
            style: AppTextStyles.textStyles_MN_30_400_black,
          ),
          CustomSpacers.height40,
          _buildSignUpButton(AppIcons.apple_icon, "Continue With Apple",
              () async {
            dynamic? user = await AuthHelper().signInWithApple();
            if (user != null) {
              // User is signed in.
            } else {
              // Sign-in failed.
            }
            // CustomNavigator.pushTo(context, AppPages.signUp);
          }),
          CustomSpacers.height15,
          _buildSignUpButton(AppIcons.facebook_icon, "Continue With Facebook",
              () {
            // CustomNavigator.pushTo(context, AppPages.signUp);
          }),
          CustomSpacers.height15,
          _buildSignUpButton(AppIcons.twitter_icon, "Continue With Twitter",
              () {
            AuthHelper().signInWithGoogle().then((value) async {
              if (value != null) {
                var token = await value.getIdToken();
                print(value);
                if (token != null) {
                  _blocReference.add(RegisterViaOAuthEvent(
                      entity: SocialAuthEntity(
                          provider: "google",
                          provider_id: token,
                          categories: args['selectedCategories'],
                          subcategories: args['selectedSubcategories'])));
                }

                // User is signed in.
              } else {
                // Sign-in failed.
              }
            });
          }),
          CustomSpacers.height15,
          _buildSignUpButton(AppIcons.google_icon, "Continue With Google",
              () async {
            AuthHelper().signInWithGoogle().then((value) async {
              if (value != null) {
                var token = await value.getIdToken();
                print(value);
                if (token != null) {
                  _blocReference.add(RegisterViaOAuthEvent(
                      entity: SocialAuthEntity(
                          provider: "google",
                          provider_id: token,
                          categories: args['selectedCategories'],
                          subcategories: args['selectedSubcategories'])));
                }

                // User is signed in.
              } else {
                // Sign-in failed.
              }
            });

            // CustomNavigator.pushTo(context, AppPages.signUp);
          }),
          CustomSpacers.height15,
          _buildSignUpButton(AppIcons.email_icon, "Continue With Email", () {
            CustomNavigator.pushTo(context, AppPages.signUp, arguments: args);
          }),
        ],
      );

  _buildSignUpButton(String path, String title, VoidCallback buttonAction) =>
      GestureDetector(
        onTap: buttonAction,
        child: Container(
          height: 46.h,
          width: 343.w,
          decoration: BoxDecoration(
              color: AppColors.Secondary,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                width: 1,
                color: Colors.black,
              )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(path),
                CustomSpacers.width6,
                Text(
                  title,
                  style: AppTextStyles.textStyles_MN_30_600_black
                      .copyWith(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      );
}
