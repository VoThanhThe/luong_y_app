import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class LanguageHelper {
  static const String _languageKey = 'language';
  static const String _onboardingKey = 'is_onboarding_completed'; // Key mới

  static Future<void> saveLanguageCode(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, code);
  }

  static Future<Locale> getSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_languageKey) ?? 'vi';
    return localeForCode(code);
  }

  static Locale localeForCode(String code) {
    switch (code) {
      case 'en':
        return const Locale('en', 'US');
      case 'vi':
      default:
        return const Locale('vi', 'VN');
    }
  }

  static Future<String> getSavedLanguageCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey) ?? 'vi';
  }

  static Future<void> saveOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }

  static Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }
}
