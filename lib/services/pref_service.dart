import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  static SharedPreferences? prefs;

  // App install thi lay ne folder sudhi no path leva.............
  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  // Write Data...............................................
  static Future<void> setValue(
      {required String key, required dynamic value}) async {
    if (value is String) {
      await prefs!.setString(key, value);
    } else if (value is int) {
      await prefs!.setInt(key, value);
    } else if (value is double) {
      await prefs!.setDouble(key, value);
    } else if (value is bool) {
      await prefs!.setBool(key, value);
    } else if (value is List<String>) {
      await prefs!.setStringList(key, value);
    } else {
      if (kDebugMode) {
        print("Please Enter valid value");
      }
    }
  }

  // Read Data.......................................................
  static String getString(String key) {
    return prefs?.getString(key) ?? "";
  }

  static int getInt(String key) {
    return prefs?.getInt(key) ?? 0;
  }

  static double getDouble(String key) {
    return prefs?.getDouble(key) ?? 0.0;
  }

  static bool getBool(String key) {
    return prefs?.getBool(key) ?? false;
  }

  static List<String> getStringList(String key) {
    return prefs?.getStringList(key) ?? [];
  }

  // Remove Data................................................
  static void removeValue(String key) {
    prefs?.remove(key);
  }

  // Clear Data..................................................
  static void clearPref() {
    prefs?.clear();
  }

  static List<String> levelBlank = List.generate(75, (index) => " ");
}
