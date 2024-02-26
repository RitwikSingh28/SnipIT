// import 'package:snipit/core/constants/app_string.dart';

// import '../../features/onboarding/data/models/user_details_model.dart';
// import '../constants/app_strings.dart';
// import '../managers/shared_preference_manager.dart';

import 'package:snipit/core/constants/app_string.dart';
import 'package:snipit/core/managers/shared_preference_manager.dart';
import 'package:snipit/features/feed/data/models/user_preference_model.dart';
import 'package:snipit/features/onboarding/data/model/userModel.dart';

class UserHelpers {
  static UserModel? userDetails;

  static setAuthToken(String token) async {
    SharedPreferencesManager.setString(STRING_KEY_APPTOKEN, token);
  }

  static setFirstTimeDone() async {
    SharedPreferencesManager.setBool(STRING_IS_FIRST_TIME, true);
  }

  static setPreferences(UserPreferenceModel prefs) async {
    SharedPreferencesManager.setObject(STRING_MY_PREFERENCES, prefs);
  }

//   static setReferralCodeAndSharer(String code) async {
//     SharedPreferencesManager.setString(STRING_REFERRAL_SHARE_KEY, code);
//   }

//   static String getRefCode() {
//     return SharedPreferencesManager.getString(STRING_REF_CODE_KEY);
//   }

//   static String getRefCodeAndSharer() {
//     return SharedPreferencesManager.getString(STRING_REFERRAL_SHARE_KEY);
//   }

  static String getAuthToken() {
    return SharedPreferencesManager.getString(STRING_KEY_APPTOKEN);
  }

  static bool getIsFirstTimeDone() {
    return SharedPreferencesManager.getBool(STRING_IS_FIRST_TIME);
  }

//   static setUserId(String id) async {
//     SharedPreferencesManager.setString(STRING_KEY_USERID, id);
//   }

//   static String getUserId() {
//     return SharedPreferencesManager.getString(STRING_KEY_USERID);
//   }

//   // static bool getIsContactPermissionGranted() {
//   //   return SharedPreferencesManager.getBool(STRING_IS_FIRST_APP_OPEN);
//   // }

  static setUserDetails(UserModel profileDetails) async {
    SharedPreferencesManager.setObject(
        STRING_KEY_PROFILE_DETAILS, profileDetails);
    userDetails = profileDetails;
  }

  static Future<dynamic> getUserDetails() async {
    Object obj = SharedPreferencesManager.getObject(STRING_KEY_PROFILE_DETAILS);
    print(obj);
    // if no details found call the api
    if (obj == false) {
      return obj;
    } else {
      print(obj);
      userDetails = UserModel.fromMap(obj as Map<String, dynamic>);
      return userDetails;
    }
  }

  static Future<dynamic> getMyPreferences() async {
    Object obj = SharedPreferencesManager.getObject(STRING_MY_PREFERENCES);
    if (obj == false) {
      return obj;
    } else {
      var prefs = UserPreferenceModel.fromMap(obj as Map<String, dynamic>);
      return prefs;
    }
  }

//   static clearUser() async {
//     SharedPreferencesManager.removeKey(STRING_KEY_USERID);
//     SharedPreferencesManager.removeKey(STRING_KEY_APPTOKEN);
//     SharedPreferencesManager.removeKey(STRING_KEY_PROFILE_DETAILS);
//     SharedPreferencesManager.removeKey(STRING_REFERRAL_SHARE_KEY);
//     SharedPreferencesManager.removeKey(STRING_REF_CODE_KEY);
//   }

  static logout() async {
    SharedPreferencesManager.removeKey(STRING_KEY_USERID);
    SharedPreferencesManager.removeKey(STRING_KEY_APPTOKEN);
    SharedPreferencesManager.removeKey(STRING_KEY_PROFILE_DETAILS);
    userDetails = null;
  }
}
