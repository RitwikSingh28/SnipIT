import 'package:flutter/material.dart';
import 'package:snipit/core/constants/app_icons.dart';
import 'package:snipit/core/constants/app_images.dart';
import 'package:snipit/features/onboarding/data/model/category_model.dart';
import 'package:snipit/features/onboarding/data/model/subcategory_model.dart';
import 'package:snipit/features/onboarding/presentation/pages/onboarding_page.dart';

class AppData {
  static List<Widget> onboardingPages = [
    OnboardingItem(
      mainDescription: "Customise and curate news ",
      colorDescription: "your way.",
      switchDescription: false,
      image: AppImages.onboarding1_image,
    ),
    OnboardingItem(
      mainDescription: "Say goodbye to generic feeds and ",
      colorDescription: "stay informed with tailored articles.",
      switchDescription: false,
      image: AppImages.onboarding2_image,
    ),
    OnboardingItem(
      mainDescription: " at the touch of a button.",
      colorDescription: " the future of news",
      switchDescription: true,
      image: AppImages.onboarding3_image,
    )
  ];

  static List<String> dropdownItems = [
    'United Kingdom',
    'Germany',
    'United States'
  ];

  static List<CategoryModel> categories = [
    CategoryModel(id: "1", name: 'All', image: AppIcons.all_category_icon),
    CategoryModel(id: "1", name: 'Music', image: AppIcons.music_category_icon),
    CategoryModel(id: "1", name: 'Sport', image: AppIcons.sports_category_icon),
    CategoryModel(id: "1", name: 'News', image: AppIcons.news_category_icon),
  ];

  static List<CategoryModel> selectedCategoryItems = [];

  static List<String> newsCategoryList = [
    'Top Stories',
    'Financial',
    'Sport',
    'Politics',
    'Technology'
  ];

  static List<String> discoverCategoryList = [
    'Top Stories',
    'Financial',
    'Sport',
    'Politics',
    'Technology'
  ];

  static List<SubscriptionPlan> subscriptionPlans = [
    SubscriptionPlan(
        id: '1', amount: 4.0, description: 'Lorem ipsum dolor sit amet'),
    SubscriptionPlan(
        id: '2',
        amount: 10.0,
        description: 'Lorem ipsum dolor sit amet',
        isBest: true),
    SubscriptionPlan(
        id: '3', amount: 18.0, description: 'Lorem ipsum dolor sit amet'),
  ];
}

class SubscriptionPlan {
  final String id;
  final double amount;
  final String description;
  final bool isBest;

  const SubscriptionPlan({
    required this.id,
    required this.amount,
    required this.description,
    this.isBest = false,
  });
}
