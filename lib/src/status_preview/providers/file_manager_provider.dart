import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:media_scanner/media_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saf/saf.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:whatsapp_status_saver/application/common/directories.dart';
import 'package:whatsapp_status_saver/src/home/domain/entities/pair.dart';

class FileManagerProvider extends ChangeNotifier {
  Future<bool> checkPermission() async {
    final status = await Permission.storage.request();
    Saf saf = Saf('Android/media/com.whatsapp/WhatsApp/Media/.Statuses');
    final isGranted =
        await saf.getDirectoryPermission(isDynamic: false) ?? false;
    List<String>? paths = await saf.getFilesPath(fileType: FileTypes.any);
    if (status.isGranted && isGranted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> askForPermission() async {
    final status = await Permission.manageExternalStorage.request();
    return status.isGranted;
  }

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
      log('Directory does not exist: ${directory.path}');
      return [];
    }
  }

  Future<List<Pair<Uint8List?, FileSystemEntity>>> getFilesVideosThumbnail(
      Directory directory) async {
    if (await directory.exists()) {
      final lister = directory.list(recursive: true, followLinks: false);
      List<Pair<Uint8List?, FileSystemEntity>> videosAndThumbnails = [];
      await for (FileSystemEntity entity in lister) {
        if (entity is File && entity.path.endsWith('.mp4')) {
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
      log('Directory does not exist: ${directory.path}');
      return [];
    }
  }

  Future<List<Pair<Uint8List?, FileSystemEntity>>>
      getSavedStatusesWithThumbnails() async {
    final lister = savedStatusDir.list(recursive: true, followLinks: false);
    List<Pair<Uint8List?, FileSystemEntity>> statusesAndThumbnails = [];
    await for (FileSystemEntity entity in lister) {
      if (entity is File) {
        if (entity.path.endsWith('.mp4')) {
          final uint8list = await VideoThumbnail.thumbnailData(
            video: entity.path,
            imageFormat: ImageFormat.JPEG,
            maxWidth: 200,
            quality: 100,
          );
          statusesAndThumbnails.add(Pair(uint8list, entity));
        } else if (entity.path.endsWith('.jpg') ||
            entity.path.endsWith('.png')) {
          statusesAndThumbnails.add(Pair(null, entity));
        }
      }
    }
    return statusesAndThumbnails;
  }

  Future<String> saveStatus(File file) async {
    final copiedStatusName = file.path.split('/').last;
    if (!await savedStatusDir.exists()) {
      await savedStatusDir.create();
    }
    try {
      final fileToBeSave = '${savedStatusDir.path}/$copiedStatusName';
      await file.copy(fileToBeSave);
      MediaScanner.loadMedia(path: fileToBeSave);
      return 'Status saved successfully';
    } catch (e) {
      return e.toString();
    }
  }
}

final fileManagerProvider = FileManagerProvider();
