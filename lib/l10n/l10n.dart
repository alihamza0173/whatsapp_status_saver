import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class L10n {
  static const localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
  static const supportedLocales = [
    Locale('ar'),
    Locale('en'),
    Locale('es'),
    Locale('fa'),
    Locale('fr'),
    Locale('hi'),
    Locale('tr'),
    Locale('ur'),
  ];

  static const Map<String, String> languages = {
    'ar': 'Arabic (العربية)',
    'en': 'English',
    'es': 'Spanish (Español)',
    'fa': 'Persian (فارسی)',
    'fr': 'French (Français)',
    'hi': 'Hindi (हिन्दी)',
    'tr': 'Turkish (Türkçe)',
    'ur': 'Urdu (اردو)',
  };
}
