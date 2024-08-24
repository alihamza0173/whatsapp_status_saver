import 'package:flutter/material.dart';
import 'package:whatsapp_status_saver/generated/l10n.dart';

extension ContextExtension on BuildContext {
  S get l10n => S.of(this);
}
