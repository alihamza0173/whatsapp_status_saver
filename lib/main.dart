import 'package:flutter/material.dart';
import 'package:whatsapp_status_saver/application/application.dart';
import 'package:whatsapp_status_saver/application/injector.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Injector(child: MyApp()));
}
