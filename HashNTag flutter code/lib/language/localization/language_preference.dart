import 'package:shared_preferences/shared_preferences.dart';

class LanguagePreference {
  static const String languageKey = "selected_language";

  static Future<void> saveLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(languageKey, languageCode);
  }

  static Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(languageKey) ?? "en";
  }
}