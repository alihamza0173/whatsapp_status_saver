import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:media_scanner/media_scanner.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:whatsapp_status_saver/src/home/domain/entities/pair.dart';
import 'package:whatsapp_status_saver/src/home/domain/repositories/whatsapp_status_repository.dart';

class WhatsappStatusRepositoryImpl extends WhatsappStatusRepository {
  @override
  Future<List<Pair<Uint8List?, FileSystemEntity>>> getImageStatus(
      Directory directory) async {
    final files = await _getFilesInDirectory(directory);
    return _filterMediaFiles(files, includeImages: true);
  }

  @override
  Future<List<Pair<Uint8List?, FileSystemEntity>>> getVideoStatus(
      Directory directory) async {
    final files = await _getFilesInDirectory(directory);
    final videosAndImages =
        _filterMediaFiles(files, includeVideos: true, includeImages: true);

    final results = await Future.wait(
      videosAndImages.map((pair) async {
        if (pair.second.path.endsWith('.mp4')) {
          final thumbnail = await _generateVideoThumbnail(pair.second.path);
          return Pair(thumbnail, pair.second);
        }
        return pair;
      }),
    );

    return results;
  }

  @override
  Future<List<Pair<Uint8List?, FileSystemEntity>>> getSavedStatus(
      Directory directory) async {
    final files = await _getFilesInDirectory(directory);
    final videoFiles = _filterMediaFiles(files, includeVideos: true);

    // Generate thumbnails concurrently
    final videosAndThumbnails = await Future.wait(
      videoFiles.map((pair) async {
        final thumbnail = await _generateVideoThumbnail(pair.second.path);
        return Pair(thumbnail, pair.second);
      }),
    );

    return videosAndThumbnails;
  }

  @override
  Future<String> saveStatus(Directory directory, File file) async {
    final copiedStatusName = file.path.split('/').last;
    if (!await directory.exists()) {
      await directory.create();
    }

    try {
      final fileToBeSaved = '${directory.path}/$copiedStatusName';
      await file.copy(fileToBeSaved);
      MediaScanner.loadMedia(path: fileToBeSaved);
      return 'Status saved successfully';
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<FileSystemEntity>> _getFilesInDirectory(
      Directory directory) async {
    if (await directory.exists()) {
      return directory.list(recursive: true, followLinks: false).toList();
    } else {
      log('Directory does not exist: ${directory.path}');
      return [];
    }
  }

  // A simple in-memory cache for thumbnails
  final Map<String, Uint8List?> _thumbnailCache = {};

  Future<Uint8List?> _generateVideoThumbnail(String videoPath) async {
    // Return from cache if available
    if (_thumbnailCache.containsKey(videoPath)) {
      return _thumbnailCache[videoPath];
    }

    // Generate the thumbnail and cache it
    final uint8list = await VideoThumbnail.thumbnailData(
      video: videoPath,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 150, // Adjust for faster performance
      quality: 80, // Adjust for faster performance
    );

    _thumbnailCache[videoPath] = uint8list; // Cache the result
    return uint8list;
  }

  List<Pair<Uint8List?, FileSystemEntity>> _filterMediaFiles(
      List<FileSystemEntity> entities,
      {bool includeVideos = false,
      bool includeImages = false}) {
    final List<Pair<Uint8List?, FileSystemEntity>> filteredFiles = [];

    for (var entity in entities) {
      if (entity is File) {
        final path = entity.path;
        final extension = path.split('.').last;

        if (includeImages && (extension == 'jpg' || extension == 'png')) {
          filteredFiles.add(Pair(null, entity));
        }

        if (includeVideos && extension == 'mp4') {
          filteredFiles.add(Pair(null, entity));
        }
      }
    }

    return filteredFiles;
  }
}
