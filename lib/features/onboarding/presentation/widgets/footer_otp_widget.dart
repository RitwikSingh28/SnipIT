import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
FooterOtpWidget(String title, String clickText) => RichText(
  text: TextSpan(children: [
    TextSpan(
        text: title,
        style: const TextStyle(
            fontFamily: "Maison Neue",
            color: AppColors.black,
            fontWeight: FontWeight.w300)),
    TextSpan(
      text: clickText,
      style: const TextStyle(
          decoration: TextDecoration.underline,
          fontFamily: "Maison Neue",
          color: Color.fromARGB(255, 25, 73, 76),
          fontWeight: FontWeight.w400),
    ),
  ]),
);