import 'dart:io';

import 'package:flutter/material.dart';
import 'package:media_scanner/media_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp_status_saver/application/common/directories.dart';

class FileManagerProvider extends ChangeNotifier {
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

  // Get all images
  Future<List<FileSystemEntity>> getFilesImages(Directory directory) async {
    if (await directory.exists()) {
      final lister = directory.list(recursive: true, followLinks: false);
      return lister.where((event) {
        final path = event.path;
        final extension = path.split('.').last;
        return extension == 'jpg' || extension == 'png';
      }).toList();
    } else {
      return [];
    }
  }

  // Get all videos
  Future<List<FileSystemEntity>> getFilesVideos(Directory directory) async {
    if (await directory.exists()) {
      final lister = directory.list(recursive: true, followLinks: false);
      return lister.where((event) => event.path.endsWith('.mp4')).toList();
    } else {
      return [];
    }
  }

  // Get all saved statuses
  Future<List<FileSystemEntity>> getSavedStatuses() {
    final lister = savedStatusDir.list(recursive: true, followLinks: false);
    return lister.toList();
  }

  // Save status
  Future<String> saveStatus(File file) async {
    final copiedStatusName = file.path.split('/').last;

    if (!await savedStatusDir.exists()) {
      await savedStatusDir.create();
    }

    try {
      final fileToBeSave = '${savedStatusDir.path}/$copiedStatusName';
      await file.copy(fileToBeSave);
      await MediaScanner.loadMedia(path: fileToBeSave);
      return 'Status saved successfully';
    } catch (e) {
      return e.toString();
    }
  }
}

final fileManagerProvider = FileManagerProvider();
