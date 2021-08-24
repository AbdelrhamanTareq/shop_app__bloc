import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late final SharedPreferences _prefs;
  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> setToken(String key, bool value) async {
    // _prefs = await SharedPreferences.getInstance();
    return _prefs.setBool(key, value);
  }

  static bool? getToken(String key) {
    // _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool(key);
  }
}
