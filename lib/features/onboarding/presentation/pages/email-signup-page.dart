import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snipit/core/constants/app_colors.dart';
import 'package:snipit/core/constants/app_text_styles.dart';
import 'package:snipit/core/helpers/user_helpers.dart';
import 'package:snipit/core/utils/custom_spacers.dart';
import 'package:snipit/core/validators.dart';
import 'package:snipit/features/onboarding/domain/entities/register-email-entity.dart';
import 'package:snipit/features/onboarding/presentation/bloc/signup/signup_bloc.dart';
import 'package:snipit/features/onboarding/presentation/widgets/footer_widget.dart';
import 'package:snipit/route/app_pages.dart';
import 'package:snipit/route/custom_navigator.dart';
import 'package:snipit/ui/injection_container.dart';
import 'package:snipit/ui/molecules/custom_button.dart';
import 'package:snipit/ui/molecules/custom_text_field.dart';

class EmailSignupPage extends StatefulWidget {
  PageController pageController;
  List<String> selectedCategories;
  List<String> selectedSubcategories;
  EmailSignupPage(
      {super.key,
      required this.pageController,
      required this.selectedCategories,
      required this.selectedSubcategories});

  @override
  State<EmailSignupPage> createState() => EmailSignupPageState();
}

class EmailSignupPageState extends State<EmailSignupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  final _bloc = sl<SignupBloc>();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  _buildBody() => BlocProvider(
        create: (context) => _bloc,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: BlocListener<SignupBloc, SignupState>(
            listener: (context, state) {
              if (state is RegisterViaEmailSuccessState) {
                CustomNavigator.pushTo(context, AppPages.verifyOtp,
                    arguments: {"email": emailController.text});
                // widget.pageController.nextPage(
                //   duration: const Duration(milliseconds: 500),
                //   curve: Curves.ease,
                // );
              }
            },
            child: BlocBuilder<SignupBloc, SignupState>(
              builder: (context, state) {
                return Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomSpacers.height20,
                          Flexible(
                            child: RichText(
                              text: const TextSpan(children: [
                                TextSpan(
                                    text: "We just need a few details to ",
                                    style: AppTextStyles
                                        .textStyles_MN_30_400_black),
                                TextSpan(
                                    text: "get started.",
                                    style: AppTextStyles
                                        .textStyles_MN_30_600_black)
                              ]),
                            ),
                          ),
                          CustomSpacers.height30,
                          _buildForm(),
                          CustomSpacers.height160,
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          const Spacer(),
                          Container(
                            color: AppColors.Secondary,
                            child: Column(
                              children: [
                                CustomSpacers.height10,
                                _buildContinueButton(),
                                CustomSpacers.height10,
                                FooterWidget(
                                  buttonAction: () {
                                    CustomNavigator.pushTo(
                                        context, AppPages.login);
                                  },
                                  clickText: "login",
                                  text: "Already have an account? ",
                                  fontSize: 14,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );

  _buildForm() => Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TextFormField(
            //   controller: emailController,
            //   decoration: InputDecoration(
            //     hintText: 'Email Address',
            //     focusedBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(30),
            //         borderSide: BorderSide(color: AppColors.primary, width: 1.5)),
            //     border:
            //         OutlineInputBorder(borderRadius: BorderRadius.circular(30)),

            //   ),

            // ),
            CustomTextField.primary(
                controller: emailController,
                borderRadius: 30,
                hint: "Email Address",
                validator: (value) => Validators.email(value),
                keyboardType: TextInputType.emailAddress),
            CustomSpacers.height15,
            CustomTextField.primary(
              controller: passwordController,
              obscureText: !_showPassword,
              maxLines: 1,
              borderRadius: 30,
              hint: "Password",
              validator: (value) => Validators.password(value),
              keyboardType: TextInputType.text,
              suffix: IconButton(
                icon: Icon(
                    _showPassword ? Icons.visibility : Icons.visibility_off,
                    color: const Color.fromARGB(126, 0, 0, 0)),
                onPressed: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
              ),
            ),

            CustomSpacers.height15,
            CustomTextField.primary(
              controller: confirmPasswordController,
              obscureText: !_showConfirmPassword,
              maxLines: 1,
              borderRadius: 30,
              hint: "Confirm Password",
              validator: (confirmPassword) => Validators.confirmPassword(
                  passwordController.text, confirmPassword ?? ""),
              keyboardType: TextInputType.text,
              suffix: IconButton(
                icon: Icon(
                  _showConfirmPassword
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: const Color.fromARGB(126, 0, 0, 0),
                ),
                onPressed: () {
                  setState(() {
                    _showConfirmPassword = !_showConfirmPassword;
                  });
                },
              ),
            ),
          ],
        ),
      );

  _buildContinueButton() => CustomButton(
        strButtonText: 'Continue',
        textStyle:
            AppTextStyles.textStyles_MN_30_600_black.copyWith(fontSize: 16),
        buttonAction: () async {
          print(UserHelpers.getAuthToken());
          if (await _formKey.currentState!.validate()) {
            _bloc.add(RegisterViaEmailEvent(
                entity: RegisterEmailEntity(
                    categories: widget.selectedCategories,
                    subcategories: widget.selectedSubcategories,
                    email: emailController.text,
                    password: passwordController.text)));
          }

          // CustomNavigator.pushTo(context, AppPages.signUpLanding);
        },
        buttonType: ButtonType.PRIMARY,
      );
}



// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:snipit/core/constants/app_data.dart';
// import 'package:snipit/core/constants/app_text_styles.dart';
// import 'package:snipit/core/utils/custom_spacers.dart';
// import 'package:snipit/features/onboarding/presentation/widgets/footer_widget.dart';
// import 'package:snipit/ui/molecules/custom_button.dart';
// import 'package:snipit/ui/molecules/custom_divider.dart';

// class _buildPage2 extends StatefulWidget {
//   PageController pageController;
//   _buildPage2({super.key, required this.pageController});

//   @override
//   State<_buildPage2> createState() => _buildPage2State();
// }

// class _buildPage2State extends State<_buildPage2> {
//   TextEditingController postcodeController = TextEditingController();

//   String _selectedItem = '';
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 0.0),
//         child: Column(
//           children: [
//             CustomSpacers.height80,
//             CustomSpacers.height30,
//             RichText(
//               text: const TextSpan(children: [
//                 TextSpan(
//                     text: "We just need a few details to ",
//                     style: AppTextStyles.textStyles_MN_30_400_black),
//                 TextSpan(
//                     text: "get started.",
//                     style: AppTextStyles.textStyles_MN_30_600_black)
//               ]),
//             ),
//             CustomSpacers.height40,
//             _buildForm(),
//             CustomSpacers.height160,
//             CustomSpacers.height80,
//             CustomSpacers.height10,
//             _buildContinueButton(),
//             CustomSpacers.height20,
//             FooterWidget(
//               buttonAction: () {
//                 CustomNavigator.pushTo(context, AppPages.login);
//               },
//               clickText: "login",
//               text: "Already have an account? ",
//               fontSize: 14,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   _buildForm() => Container(
//         height: 113,
//         width: 363,
//         decoration: BoxDecoration(
//           border: Border.all(width: 0.1),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               DropdownButtonFormField<String>(
//                 items: AppData.dropdownItems.map((String item) {
//                   return DropdownMenuItem<String>(
//                     value: item,
//                     child: Text(item),
//                   );
//                 }).toList(),
//                 onChanged: (String? value) {
//                   setState(() {
//                     _selectedItem = value ?? '';
//                   });
//                 },
//                 decoration: const InputDecoration(
//                     border: InputBorder.none,
//                     hintText: 'where are you based ?',
//                     hintStyle:
//                         AppTextStyles.textStyles_PTSans_16_400_Secondary),
//               ),
//               CustomDivider(
//                 thickness: 1,
//               ),
//               TextField(
//                 controller: postcodeController,
//                 keyboardType: TextInputType.text,
//                 onChanged: (value) {
//                   setState(() {});
//                 },
//                 decoration: const InputDecoration(
//                     border: InputBorder.none,
//                     hintText: 'Postcode',
//                     hintStyle:
//                         AppTextStyles.textStyles_PTSans_16_400_Secondary),
//               ),
//             ],
//           ),
//         ),
//       );

//   _buildContinueButton() => CustomButton(
//         strButtonText: 'Continue',
//         textStyle:
//             AppTextStyles.textStyles_MN_30_600_black.copyWith(fontSize: 16),
//         buttonAction: () {
//           widget.pageController.nextPage(
//             duration: const Duration(milliseconds: 500),
//             curve: Curves.ease,
//           );
//         },
//         buttonType: ButtonType.PRIMARY,
//       );
// }
