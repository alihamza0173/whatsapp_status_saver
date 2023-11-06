import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_status_saver/application/providers/settings_provider.dart';
import 'package:whatsapp_status_saver/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<dynamic> switchLanguage(BuildContext context) {
  final provider = context.read<SettingsProvider>();
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context)!.language),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: L10n.languages.entries
              .map(
                (e) => RadioListTile(
                  title: Text(e.value),
                  value: e.key,
                  groupValue: provider.locale?.languageCode,
                  onChanged: (value) {
                    provider.setLocale(Locale(e.key));
                    Navigator.pop(context);
                  },
                ),
              )
              .toList(),
        ),
      );
    },
  );
}
