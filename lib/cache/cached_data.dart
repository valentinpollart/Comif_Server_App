import 'package:Comif_Server_App/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CachedData {
  static String token = '';

  static Future<void> loadAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("authToken") ?? '';
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token =  '';
    prefs.remove("authToken");
  }

  static bool isLogged() {
    return token != '';
  }
}