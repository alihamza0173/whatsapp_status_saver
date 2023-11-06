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
  bool get isDarkMode {
    if (_themeMode == ThemeMode.system) {
      return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
    } else {
      return _themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
