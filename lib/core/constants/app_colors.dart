// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class AppColors {
  // Brand primary color
  static const Color primary = Color(0xFFEE9B8D); //pink
  static const Color Secondary = Color(0xFFEEE9DD); //pink

  // Text colors
  static const Color primaryText = Color.fromARGB(255, 242, 132, 130); //pink
  static const Color secondaryText = Color.fromARGB(255, 25, 34, 76); //blue
  static const Color tertiaryText = Color(0xFF111111);

  // Background colors
  static const Color pinkBackground = Color.fromARGB(255, 242, 132, 130); //pink
  static const Color blueBackground = Color.fromARGB(255, 55, 63, 81); //blue
  static const Color greenBackground = Color.fromARGB(255, 55, 63, 81); //green
  static const Color lightBackground = Color(0xFFE7E7FF);
  //Button Colors
  static const Color blueButton = Color.fromARGB(255, 20, 33, 61);
  static const Color pinkButton = Color.fromARGB(255, 242, 132, 130); //pink

  // Neutral colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color lightestGrey = Color(0xFFF7F8F9);
  static const Color lightGrey = Color(0xFFE8ECF4);
  static const Color grey = Color(0xFF8391A1);
  static const Color yellow = Color(0xFFFFC100);
  static const Color darkBlue = Color(0xFF413DDC);
  static const Color red = Colors.red;
  static const Color darkGrey = Color(0xFF3A3A3A);
  static const Color lightGrey2 = Color(0xFF94928c);
  static const Color lightGrey3 = Color(0xFFd8d8d8);

  //Toast Color
  static const Color TOAST_SUCCESS = Color(0xFF29823B);
  static const Color TOAST_ERROR = Color(0xFFFD6A85);
  static const Color TOAST_ALERT = Color(0xFFE99400);
  static const Color TOAST_INFORMATION = Color(0xFF017AAD);
  static const Color TOAST_INFORMATION_BACKGROUND = Color(0xFFE5F5FC);

  static const Color TOAST_SUCCESS_BACKGROUND = Color(0xFFEAF3EB);
  static const Color TOAST_ERROR_BACKGROUND = Color(0xFFFCEAEA);
  static const Color TOAST_ALERT_BACKGROUND = Color(0xFFFDF4E5);

  // Semantic colors
  static const Color success = Colors.green;
  static const Color info = Colors.blue;
  static const Color warning = Colors.orange;
  static const Color error = Colors.red;

  // Shimmer Colors
  static Color shimmerBaseColor = Colors.grey.shade300;
  static Color shimmerHighlightColor = Colors.grey.shade100;

}
