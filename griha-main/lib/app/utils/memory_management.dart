// ignore_for_file: constant_identifier_names

import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemoryManagement {
  static SharedPreferences? prefs;
  static Future<bool> init() async {
    prefs = await SharedPreferences.getInstance();
    return true;
  }

  static setLoginData({required String accessToken}) async {
    await setAccessToken(accessToken: accessToken);
    await setLoginStatus(status: true);
  }

  static setAccessToken({required String accessToken}) async {
    return await prefs!.setString(SharedPrefsKeys.ACCESS_TOKEN, accessToken);
  }

  static void removeAccessToken() async {
    await prefs!.remove(SharedPrefsKeys.ACCESS_TOKEN);
  }

  static String? getUserId() {
    return Jwt.parseJwt(prefs!.getString(SharedPrefsKeys.ACCESS_TOKEN)!)['id']
        .toString();
  }

  static String? getAccessToken() {
    return prefs != null
        ? prefs!.getString(SharedPrefsKeys.ACCESS_TOKEN)
        : null;
  }

  static setLoginStatus({
    required bool status,
  }) {
    return prefs!.setBool(SharedPrefsKeys.LOGIN_STATUS, status);
  }

  static bool getLoginStatus() {
    try {
      return prefs!.getBool(SharedPrefsKeys.LOGIN_STATUS)!;
    } catch (e) {
      return false;
    }
  }

  static Future<void> setRecentSearches(
      {required List<String> searches}) async {
    await prefs!.setStringList(SharedPrefsKeys.RECENT_SEARCHES, searches);
  }

  static List<String>? getRecentSearches() {
    return prefs!.getStringList(SharedPrefsKeys.RECENT_SEARCHES);
  }

  static Future<void> addRecentSearch({required String search}) async {
    List<String>? searches = getRecentSearches();
    searches ??= [];
    searches.add(search);
    await setRecentSearches(searches: searches);
  }

  static Future<void> removeRecentSearch({required String search}) async {
    List<String>? searches = getRecentSearches();
    searches ??= [];
    searches.remove(search);
    await setRecentSearches(searches: searches);
  }

  static Future<void> clearRecentSearches() async {
    await prefs!.remove(SharedPrefsKeys.RECENT_SEARCHES);
  }

  static Future<void> clearMemory() async {
    await prefs!.clear();
  }

  static Future<void> logOut() async {
    removeAccessToken();
    clearRecentSearches();
    setLoginStatus(status: false);
  }
}

class SharedPrefsKeys {
  static const String ACCESS_TOKEN = 'access_token';
  static const String LOGIN_STATUS = 'login_status';
  static const String USER_ID = 'user_id';
  static const String RECENT_SEARCHES = 'recent_searches';
}
