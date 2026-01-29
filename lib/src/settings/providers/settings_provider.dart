import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_status_saver/core/enums/status_directory.dart';
import 'package:whatsapp_status_saver/src/settings/stats/settings_state.dart';

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>(
  (ref) => SettingsNotifier()..initPrefs(),
);

class SettingsNotifier extends StateNotifier<SettingsState> {
  SharedPreferences? _prefs;

  SettingsNotifier() : super(SettingsState.initial());

  Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    await initSettings();
  }

  Future<void> initSettings() async {
    final languageCode = _prefs?.getString('languageCode');
    final themeModeIndex = _prefs?.getInt('themeMode') ?? 0;
    final whatsappDir = _prefs?.getString('whatsapp');

    final Directory? statusDir =
        whatsappDir == StatusDirectory.whatsapp.toString()
            ? StatusDirectory.whatsapp.directory
            : whatsappDir == StatusDirectory.whatsappBusiness.toString()
                ? StatusDirectory.whatsappBusiness.directory
                : null;

    final themeMode = ThemeMode.values[themeModeIndex];
    state = state.copyWith(
      locale: languageCode != null ? Locale(languageCode) : null,
      statusDirectory: statusDir,
      themeMode: themeMode,
      isDarkMode: themeMode == ThemeMode.dark,
    );
  }

  void setStatusDir(StatusDirectory dir) {
    final Directory statusDir = dir == StatusDirectory.whatsapp
        ? StatusDirectory.whatsapp.directory
        : StatusDirectory.whatsappBusiness.directory;
    final isWhatsapp = statusDir == StatusDirectory.whatsapp.directory;
    final isWhatsappBusiness =
        statusDir == StatusDirectory.whatsappBusiness.directory;
    state = state.copyWith(
      statusDirectory: statusDir,
      isWhatsapp: isWhatsapp,
      isWhatsappBusiness: isWhatsappBusiness,
    );
    _prefs?.setString('whatsapp', dir.toString());
  }

  void setLocale(Locale locale) {
    state = state.copyWith(locale: locale);
    _prefs?.setString('languageCode', locale.languageCode);
  }

  void toggleTheme(bool isDarkMode) {
    final themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    state = state.copyWith(themeMode: themeMode, isDarkMode: isDarkMode);
    _prefs?.setInt('themeMode', themeMode.index);
  }

  bool get isDarkMode {
    if (state.themeMode == ThemeMode.system) {
      return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
    }
    return state.themeMode == ThemeMode.dark;
  }
}
