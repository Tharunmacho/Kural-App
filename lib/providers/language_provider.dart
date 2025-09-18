import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  Locale _currentLocale = const Locale('en');
  static const String _languageKey = 'selected_language';

  Locale get currentLocale => _currentLocale;

  // Language mapping from the language screen format to locale codes
  static const Map<String, String> _languageMap = {
    'Englis': 'en',
    'Hind': 'hi',
    'Tami': 'ta',
    'Telug': 'te',
    'Kannad': 'kn',
    'Malayala': 'ml',
  };

  // Reverse mapping for getting display name from locale
  static const Map<String, String> _localeToLanguageMap = {
    'en': 'Englis',
    'hi': 'Hind',
    'ta': 'Tami',
    'te': 'Telug',
    'kn': 'Kannad',
    'ml': 'Malayala',
  };

  // Initialize and load saved language preference
  Future<void> initialize() async {
    await _loadSavedLanguage();
  }

  // Load saved language from SharedPreferences
  Future<void> _loadSavedLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLanguage = prefs.getString(_languageKey);
      if (savedLanguage != null && _languageMap.containsKey(savedLanguage)) {
        final localeCode = _languageMap[savedLanguage]!;
        _currentLocale = Locale(localeCode);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading saved language: $e');
    }
  }

  // Change language and save to preferences
  Future<void> changeLanguage(String languageName) async {
    try {
      debugPrint('changeLanguage called with: $languageName');
      debugPrint('Language map contains key: ${_languageMap.containsKey(languageName)}');
      debugPrint('Available keys: ${_languageMap.keys.toList()}');
      
      if (_languageMap.containsKey(languageName)) {
        final localeCode = _languageMap[languageName]!;
        debugPrint('Setting locale to: $localeCode');
        _currentLocale = Locale(localeCode);
        
        // Save to SharedPreferences
        try {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(_languageKey, languageName);
          debugPrint('Saved to SharedPreferences successfully');
        } catch (prefError) {
          debugPrint('Error saving to SharedPreferences: $prefError');
        }
        
        notifyListeners();
        debugPrint('Language changed to: $languageName ($localeCode)');
        debugPrint('notifyListeners() called');
      } else {
        debugPrint('Language name not found in map: $languageName');
      }
    } catch (e) {
      debugPrint('Error changing language: $e');
    }
  }

  // Get current language display name
  String getCurrentLanguageName() {
    return _localeToLanguageMap[_currentLocale.languageCode] ?? 'Englis';
  }

  // Get all supported locales
  static List<Locale> getSupportedLocales() {
    return _languageMap.values.map((code) => Locale(code)).toList();
  }

  // Check if a language is supported
  static bool isLanguageSupported(String languageName) {
    return _languageMap.containsKey(languageName);
  }
}

