import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class FileManagerProvider extends ChangeNotifier {
  final Directory _directory = Directory(
      '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses');

  // Check if permission is granted
  Future<bool> checkPermission() async {
    final status = await Permission.manageExternalStorage.status;
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> askForPermission() async {
    final status = await Permission.manageExternalStorage.request();
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  Stream<List<FileSystemEntity>> getFiles() {
    final lister = _directory.list(recursive: true, followLinks: false);
    return lister.toList().asStream();
  }
}

final fileManagerProvider = FileManagerProvider();
