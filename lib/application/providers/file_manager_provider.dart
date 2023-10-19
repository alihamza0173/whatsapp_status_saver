import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

class FileManagerProvider extends ChangeNotifier {
  bool _isAccessAllowed = false;

  bool get isAccessAllowed => _isAccessAllowed;

  final Directory _directory = Directory(
      '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses');
  void checkPermission() async {
    log('whatsapp: ${_directory.path}');
    if (!await _directory.exists()) {
      log('whatsapp not exists');
    }
    try {
      _directory.list().forEach((element) {
        log('whatsapp: ${element.path}');
      });
    } catch (e) {
      log('whatsapp: ${e.toString()}');
    }
  }
}
