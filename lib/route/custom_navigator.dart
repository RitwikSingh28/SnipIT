import 'package:flutter/material.dart';
import 'package:snipit/features/account/presentation/pages/updateProfile_page.dart';
import 'package:snipit/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:snipit/features/discover/presentation/pages/discover_feed.dart';
import 'package:snipit/features/discover/presentation/pages/discover_page.dart';
import 'package:snipit/features/discover/presentation/pages/select_discovery.dart';
import 'package:snipit/features/feed/presentation/pages/myfeed_details_page.dart';
import 'package:snipit/features/feed/presentation/pages/myfeed_page.dart';
import 'package:snipit/features/onboarding/presentation/pages/app_entry_page.dart';
import 'package:snipit/features/onboarding/presentation/pages/category_page.dart';
import 'package:snipit/features/onboarding/presentation/pages/forgot_password_otp_page.dart';
import 'package:snipit/features/onboarding/presentation/pages/landing_page.dart';
import 'package:snipit/features/onboarding/presentation/pages/loading_page.dart';
import 'package:snipit/features/onboarding/presentation/pages/sign_up_landing_page.dart';
import 'package:snipit/features/onboarding/presentation/pages/signup_exit_page.dart';
import 'package:snipit/features/onboarding/presentation/pages/sign_in_page.dart';
import 'package:snipit/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:snipit/features/onboarding/presentation/pages/signup_initialize_page.dart';
import 'package:snipit/features/onboarding/presentation/pages/signup_page.dart';
import 'package:snipit/features/onboarding/presentation/pages/splash_page.dart';
import 'package:snipit/features/onboarding/presentation/pages/subcategory_page.dart';
import 'package:snipit/features/onboarding/presentation/pages/verify_otp_page.dart';
import 'package:snipit/features/search_news/presentation/pages/search_news_page.dart';

import '../features/account/presentation/pages/edit_profile_page.dart';
import '../features/account/presentation/pages/profile_page.dart';
import '../features/account/presentation/pages/subscription_page.dart';
import '../features/onboarding/presentation/pages/create_new_password_screen.dart';
import '../features/onboarding/presentation/pages/forgot_password.dart';
import 'app_pages.dart';

final kNavigatorKey = GlobalKey<NavigatorState>();

class CustomNavigator {
  static Route<dynamic> controller(RouteSettings settings) {
    //use settings.arguments to pass arguments in pages
    switch (settings.name) {
      case AppPages.appEntry:
        return MaterialPageRoute(
          builder: (context) => const SplashPage(),
          settings: settings,
        );
      case AppPages.appEntryPage:
        return MaterialPageRoute(
          builder: (context) => const AppEntryPage(),
          settings: settings,
        );
      case AppPages.createNewPassword:
        return MaterialPageRoute(
          builder: (context) => const CreateNewPasswordScreen(),
          settings: settings,
        );
      case AppPages.onBoarding:
        return MaterialPageRoute(
          builder: (context) => const OnBoardingPage(),
          settings: settings,
        );

      case AppPages.signupInitialPage:
        return MaterialPageRoute(
          builder: (context) => const signupInitialPage(),
          settings: settings,
        );
      case AppPages.signUp:
        return MaterialPageRoute(
          builder: (context) => const SignUpPage(),
          settings: settings,
        );

      case AppPages.signUpExitPage:
        return MaterialPageRoute(
          builder: (context) => const SignUpExitPage(),
          settings: settings,
        );
      case AppPages.category:
        return MaterialPageRoute(
          builder: (context) => const CategoryPage(),
          settings: settings,
        );
      case AppPages.subcategory:
        return MaterialPageRoute(
          builder: (context) => const SubcategoryPage(),
          settings: settings,
        );

      case AppPages.myFeed:
        return MaterialPageRoute(
          builder: (context) => const MyFeedPage(),
          settings: settings,
        );
      // case AppPages.myFeedDetails:
      //   return MaterialPageRoute(
      //     builder: (context) => const MyFeedDetailsPage(),
      //     settings: settings,
      //   );

      case AppPages.login:
        return MaterialPageRoute(
          builder: (context) => const SignInPage(),
          settings: settings,
        );

      case AppPages.landing:
        return MaterialPageRoute(
          builder: (context) => const LandingPage(),
          settings: settings,
        );

      case AppPages.loading:
        return MaterialPageRoute(
          builder: (context) => const LoadingPage(),
          settings: settings,
        );

      case AppPages.signUpLanding:
        return MaterialPageRoute(
          builder: (context) => const SignUpLandingPage(),
          settings: settings,
        );

      case AppPages.profile:
        return MaterialPageRoute(
          builder: (context) => const ProfilePage(),
          settings: settings,
        );

      case AppPages.discover:
        return MaterialPageRoute(
          builder: (context) => const DiscoverPage(),
          settings: settings,
        );

      case AppPages.subscription:
        return MaterialPageRoute(
          builder: (context) => const SubscriptionPage(),
          settings: settings,
        );

      case AppPages.editProfile:
        return MaterialPageRoute(
          builder: (context) => const EditProfilePage(),
          settings: settings,
        );
      case AppPages.searchNews:
        return MaterialPageRoute(
          builder: (context) => const SearchNewsPage(),
          settings: settings,
        );
      case AppPages.updateProfile:
        return MaterialPageRoute(
          builder: (context) => const UpdateProfilePage(),
          settings: settings,
        );
      case AppPages.forgotPAssword:
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordPage(),
          settings: settings,
        );
      case AppPages.dashboard:
        return MaterialPageRoute(
          builder: (context) => const DashboardPage(),
        );
      case AppPages.verifyOtp:
        return MaterialPageRoute(
          builder: (context) => const VerifyOtpPage(),
          settings: settings,
        );
      case AppPages.forgotPAsswordVerifyOtp:
        return MaterialPageRoute(
          builder: (context) => VerifyOtpScreen(),
          settings: settings,
        );
      // case AppPages.selectDiscoveryOptionPage:
      //   return MaterialPageRoute(
      //     builder: (context) => const SelectDiscoverOptionsPage(onDiscoverSelected: (){}),
      //     settings: settings,
      //   );
      case AppPages.discoverFeedPage:
        return MaterialPageRoute(
          builder: (context) => const DiscoveryFeedPage(),
          settings: settings,
        );
      default:
        throw ('This route name does not exit');
    }
  }

  // Pushes to the route specified
  static Future<T?> pushTo<T extends Object?>(
    BuildContext context,
    String strPageName, {
    Object? arguments,
  }) async {
    return await Navigator.of(context, rootNavigator: true)
        .pushNamed(strPageName, arguments: arguments);
  }

  // Pop the top view
  static void pop(BuildContext context, {Object? result}) {
    Navigator.pop(context, result);
  }

  // Pops to a particular view
  static Future<T?> popTo<T extends Object?>(
    BuildContext context,
    String strPageName, {
    Object? arguments,
  }) async {
    return await Navigator.popAndPushNamed(
      context,
      strPageName,
      arguments: arguments,
    );
  }

  static void popUntilFirst(BuildContext context) {
    Navigator.popUntil(context, (page) => page.isFirst);
  }

  static void popUntilRoute(BuildContext context, String route, {var result}) {
    Navigator.popUntil(context, (page) {
      if (page.settings.name == route && page.settings.arguments != null) {
        (page.settings.arguments as Map<String, dynamic>)["result"] = result;
        return true;
      }
      return false;
    });
  }

  static Future<T?> pushReplace<T extends Object?>(
    BuildContext context,
    String strPageName, {
    Object? arguments,
  }) async {
    return await Navigator.pushReplacementNamed(
      context,
      strPageName,
      arguments: arguments,
    );
  }

  static Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
      BuildContext context,
      String strPageName, {
        Object? arguments,
      }) async {
    return await Navigator.pushNamedAndRemoveUntil(
      context,
      strPageName,
      (route) => false,
      arguments: arguments,
    );
  }
}
