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

  // Ask for permission
  Future<bool> askForPermission() async {
    final status = await Permission.manageExternalStorage.request();
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  Stream<List<FileSystemEntity>> getFilesImages() {
    final lister = _directory.list(recursive: true, followLinks: false);
    return lister
        .where((event) {
          final path = event.path;
          final extension = path.split('.').last;
          return extension == 'jpg' || extension == 'png';
        })
        .toList()
        .asStream();
  }

  Stream<List<FileSystemEntity>> getFilesVidos() {
    final lister = _directory.list(recursive: true, followLinks: false);
    return lister
        .where((event) => event.path.endsWith('.mp4'))
        .toList()
        .asStream();
  }

  Future<void> saveStus(File file) async {
    final copiedStatusName = file.path.split('/').last;

    Directory dir = Directory('/storage/emulated/0/DCIM/');

    if (await dir.exists()) {
      try {
        await file.copy('/storage/emulated/0/DCIM/Camera/$copiedStatusName');
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      debugPrint('There is not directory');
    }

    debugPrint('by');
  }
}

final fileManagerProvider = FileManagerProvider();
