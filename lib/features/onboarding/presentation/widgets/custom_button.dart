// // ignore_for_file: must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:snipit/core/constants/app_colors.dart';
// import 'package:snipit/core/constants/app_text_styles.dart';
// import 'package:snipit/core/utils/screen_utils.dart';

// class CustomButton extends StatefulWidget {
//   String title;
//   Color buttonColor;
//   double borderWidth;
//   Color borderColor;

//   CustomButton({
//     super.key,
//     required this.title,
//     required this.buttonColor,
//     required this.borderWidth,
//     required this.borderColor
//   });

//   @override
//   State<CustomButton> createState() => _CustomButtonState();
// }

// class _CustomButtonState extends State<CustomButton> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 46.h,
//       width: 343.w,
//       decoration: BoxDecoration(
//       color: widget.buttonColor,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(width: widget.borderWidth , color: widget.borderColor ,)),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 14.0),
//         child: 
//             Center(
//               child: Text(
//                 widget.title,
//                 style: AppTextStyles.textStyles_PTSans_16_400_Secondary.copyWith(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w700,
//                     color: AppColors.black),
//               ),
//             ),
            
          
//       ),
//     );
//   }
// }
