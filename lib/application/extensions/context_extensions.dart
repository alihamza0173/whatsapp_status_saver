import 'package:flutter/material.dart';
import 'package:whatsapp_status_saver/translations/app_localizations.dart';

extension ContextExtension on BuildContext {
  AppLocalizations get l10n => .of(this)!;

  void showSnackBarMessage(
    String message, {
    bool isError = false,
    Duration duration = const Duration(seconds: 3),
  }) {
    final theme = Theme.of(this);
    final Color? foregroundColor;
    final Color? backgroundColor;
    if (isError) {
      foregroundColor = theme.colorScheme.onError;
      backgroundColor = theme.colorScheme.error;
    } else {
      foregroundColor = null;
      backgroundColor = null;
    }

    ScaffoldMessenger.of(this).removeCurrentSnackBar();

    final snackBar = SnackBar(
      backgroundColor: backgroundColor,
      content: InkWell(
        onTap: () {
          ScaffoldMessenger.of(this).hideCurrentSnackBar();
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Text(message, style: TextStyle(color: foregroundColor)),
      ),
      behavior: .floating,
      duration: duration,
    );

    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}
