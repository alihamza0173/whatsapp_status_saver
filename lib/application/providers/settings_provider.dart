import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_status_saver/application/common/directories.dart';
import 'package:whatsapp_status_saver/core/enums/whatsapp.dart';

final settingsProvider = ChangeNotifierProvider(
  create: (context) => SettingsProvider(),
);

class SettingsProvider extends ChangeNotifier {
  // Singletons
  static final SettingsProvider _instance = SettingsProvider._internal();

  factory SettingsProvider() {
    return _instance;
  }

  SettingsProvider._internal();

  // Prefs instance
  SharedPreferences? _prefs;

  // Init prefs
  Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    await initSettings();
  }

  // Prefs Keys
  static const String _languageCodeKey = 'languageCode';
  static const String _themeModeKey = 'themeMode';
  static const String _whatsappKey = 'whatsapp';

  // Initial settings
  Future<void> initSettings() async {
    // Get language code
    final languageCode = _prefs?.getString(_languageCodeKey);
    _locale = languageCode != null ? Locale(languageCode) : null;
    // Get theme mode
    final themeModeIndex = _prefs?.getInt(_themeModeKey) ?? 0;
    _themeMode = ThemeMode.values[themeModeIndex];
    // Get whatsapp dir
    final whatsappDir = _prefs?.getString(_whatsappKey);
    if (whatsappDir == WhtasappStatusDir.whatsapp.toString()) {
      _statusDirectory = whatsappStatusDir;
    } else if (whatsappDir == WhtasappStatusDir.whatsappBusiness.toString()) {
      _statusDirectory = whatsappBzStatusDir;
    }
  }

  // Status Directory
  Directory _statusDirectory = whatsappStatusDir;
  Directory get statusDirectory => _statusDirectory;
  bool get isWhatsapp => _statusDirectory == whatsappStatusDir;

  void setStatusDir(WhtasappStatusDir dir) {
    if (dir == WhtasappStatusDir.whatsapp) {
      _statusDirectory = whatsappStatusDir;
    } else if (dir == WhtasappStatusDir.whatsappBusiness) {
      _statusDirectory = whatsappBzStatusDir;
    }
    _prefs?.setString(_whatsappKey, dir.toString());
    notifyListeners();
  }

  // Language settings
  Locale? _locale;
  Locale? get locale => _locale;
  void setLocale(Locale locale) {
    _locale = locale;
    _prefs?.setString(_languageCodeKey, locale.languageCode);
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
    _prefs?.setInt(_themeModeKey, _themeMode.index);
    notifyListeners();
  }
}
