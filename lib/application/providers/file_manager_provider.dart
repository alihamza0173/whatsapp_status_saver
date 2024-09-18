import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:whatsapp_status_saver/application/common/directories.dart';

class FileManagerProvider extends ChangeNotifier {
  // Check if permission is granted
  Future<bool> checkPermission() async {
    //  Saf saf = Saf('Android/media/com.whatsapp/WhatsApp/Media/.Statuses');
    // Android/media/com.whatsapp.w4b/WhatsApp Business/Media/.Statuses
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
  Future<List<Pair<Uint8List?, FileSystemEntity>>> getFilesImages(
      Directory directory) async {
    if (await directory.exists()) {
      final lister = directory.list(recursive: true, followLinks: false);
      final List<Pair<Uint8List?, FileSystemEntity>> listOfImages = [];
      await for (FileSystemEntity entity in lister) {
        final path = entity.path;

        final extension = path.split('.').last;
        if (extension == 'jpg' || extension == 'png') {
          listOfImages.add(Pair(null, entity));
        }
      }

      return listOfImages;
    } else {
      return [];
    }
  }

  Future<List<Pair<Uint8List?, FileSystemEntity>>> getFilesVideosThumbnail(
      Directory directory) async {
    if (await directory.exists()) {
      final lister = directory.list(recursive: true, followLinks: false);
      List<Pair<Uint8List?, FileSystemEntity>> videosAndThumbnails = [];

      await for (FileSystemEntity entity in lister) {
        if (entity is File && entity.path.endsWith('.png')) {
          final uint8list = await VideoThumbnail.thumbnailData(
            video: entity.path,
            imageFormat: ImageFormat.JPEG,
            maxWidth: 200,
            quality: 100,
          );
          videosAndThumbnails.add(Pair(uint8list, entity));
        }
      }

      return videosAndThumbnails;
    } else {
      return [];
    }
  }

  // Get all saved statuses (videos with thumbnails and images)
  Future<List<Pair<Uint8List?, FileSystemEntity>>>
      getSavedStatusesWithThumbnails() async {
    final lister = savedStatusDir.list(recursive: true, followLinks: false);
    List<Pair<Uint8List?, FileSystemEntity>> statusesAndThumbnails = [];

    await for (FileSystemEntity entity in lister) {
      if (entity is File) {
        if (entity.path.endsWith('.mp4')) {
          // For video files, generate thumbnails
          final uint8list = await VideoThumbnail.thumbnailData(
            video: entity.path,
            imageFormat: ImageFormat.JPEG,
            maxWidth: 200,
            quality: 100,
          );
          statusesAndThumbnails.add(Pair(uint8list, entity));
        } else if (entity.path.endsWith('.jpg') ||
            entity.path.endsWith('.png')) {
          // For image files, directly add them with null thumbnail
          statusesAndThumbnails.add(Pair(null, entity));
        }
      }
    }

    return statusesAndThumbnails;
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
      return 'Status saved successfully';
    } catch (e) {
      return e.toString();
    }
  }
}

class Pair<T1, T2> {
  final T1 first;
  final T2 second;

  Pair(this.first, this.second);
}

final fileManagerProvider = FileManagerProvider();
