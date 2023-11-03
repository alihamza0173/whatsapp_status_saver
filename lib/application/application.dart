import 'package:flutter/material.dart';
import 'package:whatsapp_status_saver/application/router/app_router.dart';
import 'package:whatsapp_status_saver/application/theme/app_theme.dart';
import 'package:whatsapp_status_saver/l10n/l10n.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouterSinglton.router,
      title: 'WhatsApp Status Saver',
      themeMode: ThemeMode.system,
      theme: AppTheme.lightThme,
      darkTheme: AppTheme.darkTheme,
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
    );
  }
}
