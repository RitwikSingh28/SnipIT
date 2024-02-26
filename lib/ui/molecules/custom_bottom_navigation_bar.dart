import 'package:flutter/material.dart';
import 'package:snipit/core/constants/app_colors.dart';
import 'package:snipit/core/constants/app_text_styles.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final labelStyle = TextStyle(
      fontSize: 12,
      height: 20 / 12,
      fontWeight: FontWeight.w400,
      fontFamily: AppFontFamily.maisonNeue,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.6),
            blurRadius: 30,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: BottomNavigationBar(
        onTap: onTap,
        currentIndex: currentIndex,
        backgroundColor: AppColors.Secondary,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        iconSize: 20,
        selectedItemColor: AppColors.black,
        unselectedItemColor: AppColors.grey,
        selectedLabelStyle: labelStyle,
        unselectedLabelStyle: labelStyle,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.move_to_inbox),
            label: 'My feed',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmarks_rounded),
            label: 'Discover',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            tooltip: '',
          ),
        ],
      ),
    );
  }
}
