import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:snipit/core/utils/screen_utils.dart';
import '../../route/custom_navigator.dart';

class ScaffoldHelpers {
  static Future<T?> showBottomSheet<T>({
    required BuildContext context,
    required Widget child,
  }) async {
    return await showModalBottomSheet<T>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      enableDrag: true,
      isDismissible: true,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          decoration: const ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            color: Colors.white,
          ),
          // padding:
          //     EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.65,
          ),
          child: child,
        ),
      ),
    );
  }

  static Future<DateTime?> showCalender(BuildContext context,
      {isFullCalender = true}) async {
    DateTime? dateTime;
    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          insetPadding: EdgeInsets.all(22.w),
          child: CalendarDatePicker(
            initialDate: DateTime.now(),
            firstDate: DateTime(1970, 1, 1),
            lastDate: DateTime.now(),
            onDateChanged: (value) {
              dateTime = value;
              CustomNavigator.pop(context);
            },
          ),
        );
      },
    );
    return dateTime;
  }

  static Future<void> showConfirmDialog(
      BuildContext context,
      VoidCallback confirmHandler,
      String title,
      ) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        title: Text(
          title,
          style: TextStyle(),
        ),
        actions: [
          TextButton(
            onPressed: () => CustomNavigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              CustomNavigator.pop(context);
              confirmHandler();
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  static Future<void> showCustomDialog(
      BuildContext context,
      Widget content,
      ) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        insetPadding: const EdgeInsets.all(10),
        child: Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 20.h,
          ),
          child: content,
        ),
      ),
    );
  }

  // static Future<XFile?> showImageSelectionBottomSheet(
  //     BuildContext context,
  //     VoidCallback? removeImageHandler,
  //     ) async {
  //   return await ScaffoldHelpers.showBottomSheet<XFile?>(
  //     context: context,
  //     child: ImageSelectorBottomSheet(removeImageHandler: removeImageHandler),
  //   );
  // }
}