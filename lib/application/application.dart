import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_status_saver/application/router/app_router.dart';
import 'package:whatsapp_status_saver/application/theme/app_theme.dart';
import 'package:whatsapp_status_saver/generated/l10n.dart';
import 'package:whatsapp_status_saver/src/settings/providers/settings_provider.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouterSingleton.router,
      title: 'WhatsApp Status Saver',
      themeMode: settingsState.themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: settingsState.locale,
    );
  }
}
