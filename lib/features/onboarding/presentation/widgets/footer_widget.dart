import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snipit/core/constants/app_colors.dart';
import 'package:snipit/route/app_pages.dart';
import 'package:snipit/route/custom_navigator.dart';

// ignore: must_be_immutable
class FooterWidget extends StatefulWidget {
  final VoidCallback buttonAction;
  String text;
  String clickText;
  double fontSize;
  FooterWidget({super.key , required this.buttonAction ,required this.clickText , required this.text , required this.fontSize });

  @override
  State<FooterWidget> createState() => _FooterWidgetState();
}

class _FooterWidgetState extends State<FooterWidget> {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text:  TextSpan(children: [
       TextSpan(
            text: widget.text,
            style:  TextStyle(
                fontFamily: "Maison Neue",
                color: AppColors.black,
                fontSize: widget.fontSize,
                fontWeight: FontWeight.w300)),
        TextSpan(
            text: widget.clickText,
            style:  TextStyle(
                decoration: TextDecoration.underline,
                fontFamily: "Maison Neue",
                color: AppColors.black,
                fontSize: widget.fontSize,
                fontWeight: FontWeight.w600),
          recognizer: TapGestureRecognizer()
                ..onTap = () {
                  CustomNavigator.pushTo(context, AppPages.login);
                  }
            ),
            
      ]),
      
    );
  }
}