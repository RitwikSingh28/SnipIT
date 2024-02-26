import 'package:flutter/material.dart';

class LoginOption {
  String title;
  String appIcon;
  VoidCallback onTap;
  LoginOption(
      {required this.title, required this.appIcon, required this.onTap});
}
