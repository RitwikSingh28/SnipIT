import 'package:flutter/material.dart';
import 'package:snipit/core/constants/app_colors.dart';
import 'package:snipit/core/constants/app_icons.dart';
import 'package:snipit/core/constants/app_text_styles.dart';
import 'package:snipit/core/constants/value_constants.dart';
import 'package:snipit/ui/atoms/image_view.dart';

class ToastThemeColor {
  final Color backGroundColor;
  final Color color;
  ToastThemeColor({required this.backGroundColor, required this.color});
}

class ToastWidget extends StatelessWidget {
  final String title;
  final ToastType type;

  const ToastWidget({
    super.key,
    this.title = "SUCCESS",
    required this.type,
  });

  ToastThemeColor _getToastTheme(ToastType type) {
    switch (type) {
      case ToastType.Success:
        return ToastThemeColor(
            backGroundColor: AppColors.TOAST_SUCCESS_BACKGROUND,
            color: AppColors.TOAST_SUCCESS);
      case ToastType.Error:
        return ToastThemeColor(
            backGroundColor: AppColors.TOAST_ERROR_BACKGROUND,
            color: AppColors.TOAST_ERROR);
      case ToastType.Alert:
        return ToastThemeColor(
            backGroundColor: AppColors.TOAST_ALERT_BACKGROUND,
            color: AppColors.TOAST_ALERT);
      case ToastType.Information:
        return ToastThemeColor(
            backGroundColor: AppColors.TOAST_INFORMATION_BACKGROUND,
            color: AppColors.TOAST_INFORMATION);
      default:
        return ToastThemeColor(
            backGroundColor: AppColors.TOAST_INFORMATION_BACKGROUND,
            color: AppColors.TOAST_INFORMATION);
    }
  }

  _getToastIcon(ToastType type) {
    switch (type) {
      case ToastType.Success:
        return Icons.tag_faces;
      case ToastType.Error:
        return Icons.error;
      case ToastType.Information:
        return Icons.info_outline_rounded;
      case ToastType.Alert:
        return Icons.warning;
      default:
        return Icons.tag_faces;
    }
  }

  Widget _toastTitle(BuildContext context) {
    return Row(
      children: [
        AbsorbPointer(
          child: ImageView(
            strIconData: AppIcons.activity, //_getToastIcon(type),
            isSVG: true,
            shape: ImageShapes.File,
            clickAction: () {},
          ),
        ),
        // Icon(Icons.info, color: _getToastTheme(type).color, size: 20),
        const SizedBox(
          width: VALUE_ACTION_BUTTON_CORNERRAIUS,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.68,
          child: Text(
            title,
            style: AppTextStyles.styleForToast
                .copyWith(color: _getToastTheme(type).color),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: _getToastTheme(type).backGroundColor),
            width: MediaQuery.of(context).size.width * 0.9,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.ideographic,
                children: [
                  _toastTitle(context),
                  const Icon(
                    Icons.close_rounded,
                    size: 12,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
