import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/services.dart';
import 'package:snipit/core/managers/shared_preference_manager.dart';
import 'package:snipit/firebase_options.dart';
import '../../ui/injection_container.dart' as di;
import 'package:firebase_core/firebase_core.dart';

import 'notification_manager.dart';

class AppManager {
  static Future<void> initialize() async {
    await FCMNotificationManager.initializeForegroundNotificationSetup();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // await Firebase.initializeApp();
    await SharedPreferencesManager.init();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseAppCheck.instance.activate();
    await di.init();
  }
}
