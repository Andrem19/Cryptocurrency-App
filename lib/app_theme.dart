import 'package:shared_preferences/shared_preferences.dart';

class AppTheme {
  static bool isDarkModeEnables = false;

  static Future<void> getThemeValue() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isDarkModeEnables = pref.getBool('isDarkMode') ?? false;
  }
}
