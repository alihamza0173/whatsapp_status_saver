import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsapp_status_saver/core/enums/status_directory.dart';

class SettingsState {
  final Locale? locale;
  final ThemeMode themeMode;
  final Directory statusDirectory;
  final bool isDarkMode;
  final bool isWhatsapp;
  final bool isWhatsappBusiness;

  SettingsState({
    required this.locale,
    required this.themeMode,
    required this.statusDirectory,
    required this.isWhatsapp,
    required this.isDarkMode,
    required this.isWhatsappBusiness,
  });

  static SettingsState initial() {
    return SettingsState(
      locale: null,
      themeMode: ThemeMode.system,
      statusDirectory: StatusDirectory.whatsapp.directory,
      isDarkMode: false,
      isWhatsapp: true,
      isWhatsappBusiness: false,
    );
  }

  SettingsState copyWith({
    Locale? locale,
    ThemeMode? themeMode,
    Directory? statusDirectory,
    bool? isDarkMode,
    bool? isWhatsapp,
    bool? isWhatsappBusiness,
  }) {
    return SettingsState(
      locale: locale ?? this.locale,
      themeMode: themeMode ?? this.themeMode,
      statusDirectory: statusDirectory ?? this.statusDirectory,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isWhatsapp: isWhatsapp ?? this.isWhatsapp,
      isWhatsappBusiness: isWhatsappBusiness ?? this.isWhatsappBusiness,
    );
  }
}
