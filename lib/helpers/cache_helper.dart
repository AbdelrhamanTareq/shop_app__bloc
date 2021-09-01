import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late final SharedPreferences _prefs;
  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> setOnboarding(String key, bool value) async {
    // _prefs = await SharedPreferences.getInstance();
    return await _prefs.setBool(key, value);
  }

  static bool? getOnboarding(String key) {
    // _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool(key);
  }

  static Future<bool> setToken(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  static String? getToken(String key) {
    return _prefs.getString(key);
  }

  static Future<bool> deletePref(String key) async {
    return await _prefs.remove(key);
  }
}
