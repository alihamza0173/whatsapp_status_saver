import 'dart:io';

import 'package:flutter/material.dart';

class SettingsState {
  final Locale? locale;
  final ThemeMode themeMode;
  final Directory statusDirectory;
  final bool isDarkMode;

  SettingsState({
    required this.locale,
    required this.themeMode,
    required this.statusDirectory,
    this.isDarkMode = false,
  });

  SettingsState copyWith({
    Locale? locale,
    ThemeMode? themeMode,
    Directory? statusDirectory,
    bool? isDarkMode,
  }) {
    return SettingsState(
      locale: locale ?? this.locale,
      themeMode: themeMode ?? this.themeMode,
      statusDirectory: statusDirectory ?? this.statusDirectory,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}
