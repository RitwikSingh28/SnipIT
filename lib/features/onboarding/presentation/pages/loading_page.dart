import 'dart:async';

import 'package:flutter/material.dart';
import 'package:snipit/core/constants/app_colors.dart';
import 'package:snipit/core/constants/app_text_styles.dart';
import 'package:snipit/route/app_pages.dart';
import 'package:snipit/route/custom_navigator.dart';
import 'package:snipit/ui/molecules/custom_scaffold.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await Future<void>.delayed(Duration(seconds: 2));
    if (!mounted) {
      return;
    }
    CustomNavigator.pushTo(context, AppPages.dashboard);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      autoImplyLeading: false,
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: 60),
          child: Text.rich(
            TextSpan(
              style: TextStyle(
                fontSize: 30,
                color: AppColors.black,
                fontFamily: AppFontFamily.maisonNeue,
              ),
              children: [
                TextSpan(
                  text: 'Just loading ',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: 'your stories...',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
