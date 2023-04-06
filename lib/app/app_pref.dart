// ignore_for_file: public_member_api_docs, sort_constructors_first, constant_identifier_names
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_ONBOARDING_SCREEN_VIEWED = "PREFS_KEY_ONBOARDING_SCREEN_VIEWED";
const String PREFS_KEY_USER_LOGGED_IN = "PREFS_KEY_USER_LOGGED_IN";
const String PREFS_KEY_USER_ID = "PREFS_KEY_USER_ID";

class AppPrefrences {
  final SharedPreferences _sharedPreferences;
  AppPrefrences(this._sharedPreferences);

  // User ID

  Future<void> setUserId(String uid) async {
    _sharedPreferences.setString(PREFS_KEY_USER_ID, uid);
  }

  Future<String> getUserId() async {
    return _sharedPreferences.getString(PREFS_KEY_USER_ID) ?? "chihab";
  }

  // User logged in

  Future<void> setUserLoggedIn() async {
    _sharedPreferences.setBool(PREFS_KEY_USER_LOGGED_IN, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(PREFS_KEY_USER_LOGGED_IN) ?? false;
  }

  // OnBoarding Viewd
  Future<void> setOnBoardingScreenViewed() async {
    _sharedPreferences.setBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED, true);
  }

  Future<bool> isOnBoardingScreenViewed() async {
    return _sharedPreferences.getBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED) ?? false;
  }
}
