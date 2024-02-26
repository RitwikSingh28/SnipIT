import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:snipit/core/constants/app_colors.dart';
import 'package:snipit/core/constants/value_constants.dart';
import 'package:snipit/core/managers/app_manager.dart';
import 'package:snipit/core/utils/screen_utils.dart';
import 'package:snipit/features/onboarding/presentation/pages/splash_page.dart';
import 'package:snipit/route/app_pages.dart';
import 'package:snipit/route/custom_navigator.dart';
import 'package:snipit/utils/overlay-manager.dart';
import 'core/managers/notification_manager.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  FCMNotificationManager.showNotification(message);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppManager.initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.instance.getToken().then((token) {
    print(token);
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
        VALUE_FIGMA_DESIGN_WIDTH,
        VALUE_FIGMA_DESIGN_HEIGHT,
      ),
      allowFontScaling: true,
      builder: () => MaterialApp(
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        title: 'SnipIt',
        initialRoute: AppPages.appEntry,
        onGenerateRoute: CustomNavigator.controller,
        navigatorKey: kNavigatorKey,
        theme: ThemeData(
            scaffoldBackgroundColor: AppColors.Secondary,
            appBarTheme: AppBarTheme(
                color: AppColors.Secondary,
                elevation: 0)), // ThemeData.light(),
        builder: OverlayManager.transitionBuilder(),
        scrollBehavior: ScrollConfiguration.of(context).copyWith(
          physics: const BouncingScrollPhysics(),
        ),
        home: const SplashPage(),
      ),
    );
  }
}
