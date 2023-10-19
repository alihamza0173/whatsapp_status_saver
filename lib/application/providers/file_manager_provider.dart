import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class FileManagerProvider extends ChangeNotifier {
  bool _isAccessAllowed = false;

  bool get isAccessAllowed => _isAccessAllowed;

  final Directory _directory = Directory(
      '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses');
  Future<bool> checkPermission() async {
    final status = await Permission.manageExternalStorage.status;
    if (status.isGranted) {
      _isAccessAllowed = true;

      log('permission granted');
      return true;
    } else {
      final result = await Permission.manageExternalStorage.request();
      log('permission result: $result');
      if (result.isGranted) {
        _isAccessAllowed = true;
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
        return true;
      } else if (status.isPermanentlyDenied) {
        _isAccessAllowed = false;
        openAppSettings().then((value) => log('open app settings: $value'));
        return false;
      } else {
        _isAccessAllowed = false;
        return false;
      }
    }
  }
}
