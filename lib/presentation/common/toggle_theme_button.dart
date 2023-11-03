import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_status_saver/application/providers/settings_provider.dart';

class ToggleTheme extends StatelessWidget {
  const ToggleTheme({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<SettingsProvider>().isDarkMode;
    return IconButton(
      onPressed: () {
        context.read<SettingsProvider>().toggleTheme();
      },
      icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
    );
  }
}
