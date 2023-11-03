import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_status_saver/application/application.dart';
import 'package:whatsapp_status_saver/application/theme/theme_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider(
    create: (_) => ThemeManager(),
    child: const MyApp(),
  ));
}
