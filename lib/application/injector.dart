import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_status_saver/application/theme/theme_manager.dart';

class Injector extends StatelessWidget {
  const Injector({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeManager(),
      child: child,
    );
  }
}
