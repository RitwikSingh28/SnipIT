import 'package:flutter/material.dart';
import 'package:snipit/core/constants/app_images.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/value_constants.dart';

class CustomScaffold extends StatelessWidget {
  final bool autoImplyLeading;
  final bool showBackgroundImage;
  final List<Widget>? actions;
  final Widget body;
  final Widget? appBarTitle;

  const CustomScaffold({
    super.key,
    this.autoImplyLeading = true,
    this.showBackgroundImage = true,
    required this.body,
    this.actions,
    this.appBarTitle
  });

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: appBarTitle,
      automaticallyImplyLeading: autoImplyLeading,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.black,
      actions: actions,
    );

    return Scaffold(
      backgroundColor: AppColors.Secondary,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: appBar,
      body: Stack(
        children: [
          if (showBackgroundImage)
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  opacity: 0.08,
                  image: AssetImage(AppImages.scaffoldBackground),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top +
                  appBar.preferredSize.height +
                  VALUE_STANDARD_SCREEN_PADDING,
              bottom: VALUE_STANDARD_SCREEN_PADDING,
              left: VALUE_STANDARD_SCREEN_PADDING,
              right: VALUE_STANDARD_SCREEN_PADDING,
            ),
            child: body,
          ),
        ],
      ),
    );
  }
}
