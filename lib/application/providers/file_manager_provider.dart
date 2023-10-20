import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class FileManagerProvider extends ChangeNotifier {
  final Directory _directory = Directory(
      '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses');

  // Check if permission is granted
  Future<bool> checkPermission() async {
    final status = await Permission.manageExternalStorage.status;
    if (status.isGranted) {
      getVideoFiles();
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

  getVideoFiles() async {
    final lister = _directory.list(recursive: true, followLinks: false);
    final listOfVideos = lister.where((event) => event.path.endsWith('.mp4'));
    listOfVideos.forEach((element) {
      log(element.path);
      // final uint8list = await VideoThumbnail.thumbnailData(
      //   video: videofile.path,
      //   imageFormat: ImageFormat.JPEG,
      //   maxWidth:
      //       128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      //   quality: 25,
      // );
    });
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
}

final fileManagerProvider = FileManagerProvider();
