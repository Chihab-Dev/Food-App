// ignore_for_file: public_member_api_docs, sort_constructors_first, constant_identifier_names
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_ONBOARDING_SCREEN_VIEWED = "PREFS_KEY_ONBOARDING_SCREEN_VIEWED";
const String PREFS_KEY_USER_LOGGED_IN = "PREFS_KEY_USER_LOGGED_IN";
const String PREFS_KEY_USER_ID = "PREFS_KEY_USER_ID";
const String PREFS_KEY_ORDER_ID = "PREFS_KEY_ORDER_ID";

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

  Future<void> removeUserId() async {
    await _sharedPreferences.remove(PREFS_KEY_USER_ID);
  }

  // User logged in

  Future<void> setUserLoggedIn() async {
    _sharedPreferences.setBool(PREFS_KEY_USER_LOGGED_IN, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(PREFS_KEY_USER_LOGGED_IN) ?? false;
  }

  Future<void> removeUserLoggedIn() async {
    await _sharedPreferences.remove(PREFS_KEY_USER_LOGGED_IN);
  }

  // OnBoarding Viewd

  Future<void> setOnBoardingScreenViewed() async {
    _sharedPreferences.setBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED, true);
  }

  Future<bool> isOnBoardingScreenViewed() async {
    return _sharedPreferences.getBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED) ?? false;
  }

  // User Order ID

  Future<void> setOrderId(String orderId) async {
    await _sharedPreferences.setString(PREFS_KEY_ORDER_ID, orderId);
  }

  Future<String?> getOrderId() async {
    return _sharedPreferences.getString(PREFS_KEY_ORDER_ID);
  }

  Future<void> removeOrderId() async {
    _sharedPreferences.remove(PREFS_KEY_ORDER_ID);
  }
}
