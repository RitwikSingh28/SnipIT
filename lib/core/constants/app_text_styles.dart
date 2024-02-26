// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppFontFamily {
  static const String puritan = 'Puritan';
  static const String plusJakartaSans = "Plus Jakarta Sans";
  static const String pTSans = "PT Sans";
  static const String maisonNeue = "Maison Neue";
}

class AppTextStyles {
  static const subTextStyle = TextStyle(
      fontSize: 32,
      color: AppColors.primary,
      fontFamily: "Lato",
      fontWeight: FontWeight.w800);
  static const subTextStyle16_500 = TextStyle(
      fontSize: 16, color: AppColors.primary, fontWeight: FontWeight.w500);
  static const subTextStyle16_400 = TextStyle(
      fontSize: 16, color: AppColors.primary, fontWeight: FontWeight.w400);

  static const defaultTextStyle = TextStyle(
      fontSize: 25,
      color: AppColors.primaryText,
      fontWeight: FontWeight.w400,
      fontFamily: "Poppins");
  static const defaultTextStyle15_400 = TextStyle(
      fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.primaryText);
  static const defaultTextStyle15_400_PRIMARY = TextStyle(
      fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.primary);
  static const labelStyle = TextStyle(
      fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.grey);
  static const buttonTextStyle = TextStyle(
      color: AppColors.white, fontSize: 20, fontWeight: FontWeight.w600);

  static const textStyles_Puritan_30_400_Secondary = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w400,
    fontFamily: "Puritan",
    color: Colors.black,
  );
  static const textStyles_PlusJakartaSans_30_700_Primary = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w400,
    fontFamily: "Plus Jakarta Sans",
    color: AppColors.primary,
  );
  static const textStyles_PTSans_16_400_Secondary = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: "PT Sans",
    color: Colors.black,
  );
  static const styleForToast =
      TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w400);
  static const textStyles_MN_30_400_black = TextStyle(
      fontFamily: "Maison Neue",
      color: AppColors.black,
      fontSize: 26,
      fontWeight: FontWeight.w400);
  static const textStyles_MN_30_600_black = TextStyle(
      fontFamily: "Maison Neue",
      color: AppColors.black,
      fontSize: 26,
      fontWeight: FontWeight.w600);

  static const textstyles_16_600 = TextStyle(color: AppColors.darkGrey,fontSize: 16,fontWeight: FontWeight.w600);
}
