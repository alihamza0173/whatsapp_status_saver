import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_status_saver/application/providers/settings_provider.dart';

class ToggleThemeSwitch extends StatelessWidget {
  const ToggleThemeSwitch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<SettingsProvider>().isDarkMode;
    return Theme(
      data: ThemeData(
        useMaterial3: false,
      ),
      child: Switch(
        value: isDarkMode,
        activeColor: Colors.green,
        onChanged: (value) {
          context.read<SettingsProvider>().toggleTheme(value);
        },
      ),
    );
  }
}
