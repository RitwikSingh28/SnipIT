// ignore_for_file: unused_field, must_be_immutable, non_constant_identifier_names, unused_import, camel_case_types, prefer_final_fields

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snipit/core/constants/app_colors.dart';
import 'package:snipit/core/constants/app_data.dart';
import 'package:snipit/core/constants/app_text_styles.dart';
import 'package:snipit/core/utils/custom_spacers.dart';
import 'package:snipit/core/utils/screen_utils.dart';
import 'package:snipit/features/onboarding/presentation/bloc/signup/signup_bloc.dart';
import 'package:snipit/features/onboarding/presentation/pages/email-signup-page.dart';
import 'package:snipit/features/onboarding/presentation/pages/verify_otp_page.dart';
import 'package:snipit/features/onboarding/presentation/widgets/footer_widget.dart';
import 'package:snipit/route/app_pages.dart';
import 'package:snipit/route/custom_navigator.dart';
import 'package:snipit/ui/injection_container.dart';
import 'package:snipit/ui/molecules/custom_button.dart';
import 'package:snipit/ui/molecules/custom_divider.dart';
import 'package:snipit/ui/molecules/custom_text_field.dart';

import '../../../../ui/molecules/custom_scaffold.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  static PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final List<Widget> _pages = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final Map<dynamic, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>;
    var _selectedCategoryIds = args["selectedCategories"];
    var _selectedSubcategories = args["selectedSubcategories"];
    _pages.addAll([
      EmailSignupPage(
          pageController: _pageController,
          selectedSubcategories: _selectedSubcategories??[],
          selectedCategories: _selectedCategoryIds??[]),
    ]);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: CustomScaffold(
        // backgroundColor: AppColors.Secondary,
        // appBar: AppBar(
        //   leading: GestureDetector(
        //       onTap: () {
        //         _currentPage != 0 ?  _pageController.previousPage(
        //           duration: const Duration(milliseconds: 500),
        //           curve: Curves.ease,
        //         ):CustomNavigator.pop(context);
        //       },
        //       child: const Icon(
        //         Icons.arrow_back,
        //         color: AppColors.black,
        //       )),
        //   automaticallyImplyLeading: false,
        //   elevation: 0,
        //   backgroundColor: AppColors.Secondary,
        // ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildPageViewSlider(),
              CustomSpacers.height30,
            ]),
      ),
    );
  }

  _buildPageViewSlider() => Expanded(
        child: PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          itemCount: _pages.length,
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
          itemBuilder: (BuildContext context, int index) {
            return _pages[index];
          },
        ),
      );
}
