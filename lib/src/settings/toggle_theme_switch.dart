import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_status_saver/src/settings/providers/settings_provider.dart';

class ToggleThemeSwitch extends ConsumerWidget {
  const ToggleThemeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsProvider).isDarkMode;

    return Theme(
      data: ThemeData(useMaterial3: false),
      child: Switch(
        value: isDarkMode,
        activeThumbColor: Colors.green,
        onChanged: (value) {
          ref.read(settingsProvider.notifier).toggleTheme(value);
        },
      ),
    );
  }
}
