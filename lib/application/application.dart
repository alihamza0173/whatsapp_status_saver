import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_status_saver/application/router/app_router.dart';
import 'package:whatsapp_status_saver/application/theme/app_theme.dart';
import 'package:whatsapp_status_saver/application/theme/theme_manager.dart';
import 'package:whatsapp_status_saver/l10n/l10n.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeManager>().themeMode;
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouterSinglton.router,
      title: 'WhatsApp Status Saver',
      themeMode: themeMode,
      theme: AppTheme.lightThme,
      darkTheme: AppTheme.darkTheme,
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
    );
  }
}
