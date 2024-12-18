import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:scan_media/scan_media.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:whatsapp_status_saver/src/home/domain/entities/pair.dart';
import 'package:whatsapp_status_saver/src/home/domain/repositories/whatsapp_status_repository.dart';

class WhatsappStatusRepositoryImpl extends WhatsappStatusRepository {
  @override
  Future<List<Pair<Uint8List?, FileSystemEntity>>> getImageStatus(
    Directory directory,
  ) async {
    final files = await _getFilesFromDirectory(directory);
    return _filterMediaFiles(files, includeImages: true);
  }

  @override
  Future<List<Pair<Uint8List?, FileSystemEntity>>> getVideoStatus(
    Directory directory,
  ) async {
    final files = await _getFilesFromDirectory(directory);
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
  Future<List<Pair<Uint8List?, FileSystemEntity>>> getSavedStatus(
    Directory directory,
  ) async {
    final files =
        await directory.list(recursive: true, followLinks: false).toList();
    final mediaFiles = _filterMediaFiles(
      files,
      includeVideos: true,
      includeImages: true,
    );

    // Generate thumbnails concurrently for videos
    final mediaAndThumbnails = await Future.wait(
      mediaFiles.map((pair) async {
        if (pair.second.path.endsWith('.mp4')) {
          // Generate thumbnail for videos only
          final thumbnail = await _generateVideoThumbnail(pair.second.path);
          return Pair(thumbnail, pair.second);
        }
        return pair;
      }),
    );

    return mediaAndThumbnails;
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
      ScanMedia().scan(fileToBeSaved);
      return 'Status saved successfully';
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<FileSystemEntity>> _getFilesFromDirectory(
    Directory directory,
  ) async {
    try {
      if (await directory.exists()) {
        return directory.list().toList();
      } else {
        return [];
      }
    } catch (e) {
      log('Error getting files from SAF directory: $e');
      return [];
    }
  }

  // Generate video thumbnail
  Future<Uint8List?> _generateVideoThumbnail(String videoPath) async {
    return await VideoThumbnail.thumbnailData(
      video: videoPath,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 200,
      quality: 100,
    );
  }

  List<Pair<Uint8List?, FileSystemEntity>> _filterMediaFiles(
      List<FileSystemEntity> entities,
      {bool includeVideos = false,
      bool includeImages = false}) {
    final List<Pair<Uint8List?, FileSystemEntity>> filteredFiles = [];

    for (var entity in entities) {
      if (entity is File) {
        final path = entity.path;
        final extension = path.split('.').last.toLowerCase();

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
