import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomDivider extends StatelessWidget {
  double thickness;
  CustomDivider({super.key, this.thickness = 1});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Divider(
      thickness: thickness,
    ));
  }
}
