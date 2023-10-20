import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class FileManagerProvider extends ChangeNotifier {
  bool _isAccessAllowed = false;

  bool get isAccessAllowed => _isAccessAllowed;

  final Directory _directory = Directory(
      '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses');

  File get file => File(
      '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses/7e3483e083cc4f278230e6341aac3292.jpg');

  Future<Uint8List?> get file2 async {
    final videofile = File(
        '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses/93695ac9487f4052b548657144891155.mp4');
    final uint8list = await VideoThumbnail.thumbnailData(
      video: videofile.path,
      imageFormat: ImageFormat.JPEG,
      maxWidth:
          128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 25,
    );
    return uint8list;
  }

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

final fileManagerProvider = FileManagerProvider();
