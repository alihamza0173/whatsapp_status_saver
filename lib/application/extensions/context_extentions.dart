import 'package:flutter/material.dart';
import 'package:whatsapp_status_saver/generated/l10n.dart';

extension ContextExtension on BuildContext {
  S get l10n => S.of(this);

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
        child: Text(
          message,
          style: TextStyle(color: foregroundColor),
        ),
      ),
      behavior: SnackBarBehavior.floating,
      duration: duration,
    );

    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}
