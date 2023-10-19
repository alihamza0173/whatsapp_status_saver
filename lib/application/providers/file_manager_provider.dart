import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class FileManagerProvider extends ChangeNotifier {
  bool _isAccessAllowed = false;

  bool get isAccessAllowed => _isAccessAllowed;

  final Directory _directory = Directory(
      '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses');

  File get file => File(
      '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses/7e3483e083cc4f278230e6341aac3292.jpg');

  // File get file2 => File(
  //     '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses/93695ac9487f4052b548657144891155.mp4');

  // Check if permission is granted
  Future<bool> checkPermission() async {
    final status = await Permission.manageExternalStorage.status;

    if (status.isGranted) {
      _isAccessAllowed = true;
      log('permission granted');
      getFiles();
      return true;
    } else {
      final result = await Permission.manageExternalStorage.request();
      log('permission result: $result');
      if (result.isGranted) {
        _isAccessAllowed = true;
        getFiles();
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

  Future<List<FileSystemEntity>> getFiles() async {
    final files = await _directory.list().toList();
    log('files: ${files.runtimeType}, ${files.length}, ${files[4]}, ${files.first.runtimeType}');
    return files;
  }
}
