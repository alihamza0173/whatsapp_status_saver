import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_status_saver/application/providers/settings_provider.dart';

class ToggleThemeIcon extends StatelessWidget {
  const ToggleThemeIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<SettingsProvider>().isDarkMode;
    return Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode);
  }
}
