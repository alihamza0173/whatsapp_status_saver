import 'package:flutter/material.dart';
import 'package:whatsapp_status_saver/application/application.dart';
import 'package:whatsapp_status_saver/application/injector.dart';
import 'package:whatsapp_status_saver/application/providers/settings_provider.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await SettingsProvider().initPrefs();
  runApp(const Injector(child: MyApp()));
}
