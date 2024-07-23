import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_status_saver/application/extenstions/context_extentions.dart';
import 'package:whatsapp_status_saver/application/providers/settings_provider.dart';
import 'package:whatsapp_status_saver/l10n/l10n.dart';

Future<dynamic> switchLanguage(BuildContext context) {
  final provider = context.read<SettingsProvider>();
  final currentLocale = Localizations.localeOf(context);
  String selected = currentLocale.languageCode;

  return showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(context.l10n.language),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: L10n.languages.entries
                    .map(
                      (e) => RadioListTile(
                        shape: selected == e.key
                            ? RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: const BorderSide(
                                  color: Colors.green,
                                ),
                              )
                            : null,
                        title: Text(e.value),
                        value: e.key,
                        groupValue: selected,
                        onChanged: (value) {
                          setState(() {
                            selected = e.key;
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(context.l10n.cancel),
              ),
              TextButton(
                onPressed: () {
                  provider.setLocale(Locale(selected));
                  Navigator.pop(context);
                },
                child: Text(context.l10n.ok),
              ),
            ],
          );
        },
      );
    },
  );
}
