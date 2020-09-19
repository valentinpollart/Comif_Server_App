import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static String token = '';
  static bool isAdmin = false;
  static int userId;

  static Future<void> loadAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("authToken") ?? '';
  }

  static Future<void> loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt("userId") ?? null;
    isAdmin = prefs.getBool("isAdmin") ?? false;
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token =  '';
    userId = null;
    isAdmin = false;
    prefs.remove("authToken");
    prefs.remove("userId");
  }

  static bool isLogged() {
    return token != '';
  }
}

class CachedData {
  static var cacheDir;

  static void initCache() async {
    cacheDir = await getTemporaryDirectory();
  }

  static Future<bool> isCached(String fileName) async {
    return await File(cacheDir.path + "/" + fileName).exists();
  }

  static dynamic fetch(String fileName) async {
    return File(cacheDir.path + "/" + fileName).readAsStringSync();
  }
}