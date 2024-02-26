import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:snipit/core/constants/app_colors.dart';

import 'package:snipit/route/custom_navigator.dart';
import 'package:snipit/utils/overlay-manager.dart';

class UiHelpers {
  static double get keyboardHeight =>
      MediaQuery.of(kNavigatorKey.currentContext!).viewInsets.bottom;

  static void hideKeyboard() {
    FocusScope.of(kNavigatorKey.currentContext!).requestFocus(FocusNode());
  }

  static showLoader() {
    OverlayManager.showLoader(opacity: 0.1, color: Colors.red);
  }

  static Widget getProgressGhost({height = 0.0, width = 0.0}) {
    return Center(
        child: Shimmer.fromColors(
            baseColor: AppColors.lightBackground,
            highlightColor: AppColors.white,
            period: const Duration(seconds: 2),
            child: Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(
                color: AppColors.primary,
              ),
            )));
  }

  static hideLoader() {
    OverlayManager.hideOverlay();
  }
}
