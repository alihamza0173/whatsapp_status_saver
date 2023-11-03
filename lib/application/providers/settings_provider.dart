import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  // Language settings
  Locale? _locale;
  Locale? get locale => _locale;
  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  // Theme settings
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme() {
    switch (_themeMode) {
      case ThemeMode.dark:
        _themeMode = ThemeMode.light;
        break;
      case ThemeMode.light:
        _themeMode = ThemeMode.dark;
        break;
      case ThemeMode.system:
        _themeMode = ThemeMode.dark;
        break;
      default:
        _themeMode = ThemeMode.system;
        break;
    }
    notifyListeners();
  }
}
