import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  // Singleton
  static final SettingsProvider _instance = SettingsProvider._internal();

  factory SettingsProvider() {
    return _instance;
  }

  SettingsProvider._internal();

  // Initial settings
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('languageCode') ?? 'en';
    _locale = Locale(languageCode);
    final themeModeIndex = prefs.getInt('themeMode') ?? 0;
    _themeMode = ThemeMode.values[themeModeIndex];
  }

  // Language settings
  Locale? _locale;
  Locale? get locale => _locale;
  void setLocale(Locale locale) {
    _locale = locale;
    final prefs = SharedPreferences.getInstance();
    prefs.then((value) => value.setString('languageCode', locale.languageCode));
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
    final prefs = SharedPreferences.getInstance();
    prefs.then((value) => value.setInt('themeMode', _themeMode.index));
    notifyListeners();
  }
}

final SettingsProvider settingsProvider = SettingsProvider();
