import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:scan_media/scan_media.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:whatsapp_status_saver/src/home/domain/entities/whatsapp_status.dart';
import 'package:whatsapp_status_saver/src/home/domain/repositories/whatsapp_status_repository.dart';

class WhatsappStatusRepositoryImpl extends WhatsappStatusRepository {
  @override
  Future<List<WhatsappStatus>> getImageStatus(Directory directory) async {
    final files = await _getFilesFromDirectory(directory);
    return _filterMediaFiles(files, includeImages: true);
  }

  @override
  Future<List<WhatsappStatus>> getVideoStatus(Directory directory) async {
    final files = await _getFilesFromDirectory(directory);
    final videoFiles = _filterMediaFiles(files, includeVideos: true);

    // Generate thumbnails concurrently
    final videosAndThumbnails = await Future.wait(
      videoFiles.map((status) async {
        final thumbnail = await _generateVideoThumbnail(status.file.path);
        return WhatsappStatus(file: status.file, thumbnail: thumbnail);
      }),
    );

    return videosAndThumbnails;
  }

  @override
  Future<List<WhatsappStatus>> getSavedStatus(Directory directory) async {
    final files = await directory
        .list(recursive: true, followLinks: false)
        .toList();
    final mediaFiles = _filterMediaFiles(
      files,
      includeVideos: true,
      includeImages: true,
    );

    // Generate thumbnails concurrently for videos
    final mediaAndThumbnails = await Future.wait(
      mediaFiles.map((status) async {
        if (status.file.path.endsWith('.mp4')) {
          // Generate thumbnail for videos only
          final thumbnail = await _generateVideoThumbnail(status.file.path);
          return WhatsappStatus(file: status.file, thumbnail: thumbnail);
        }
        return status;
      }),
    );

    return mediaAndThumbnails;
  }

  @override
  Future<void> saveStatus(Directory directory, File file) async {
    final copiedStatusName = file.path.split('/').last;
    if (!await directory.exists()) {
      await directory.create();
    }

    try {
      final fileToBeSaved = '${directory.path}/$copiedStatusName';
      await file.copy(fileToBeSaved);
      ScanMedia().scan(fileToBeSaved);
    } catch (e) {
      rethrow;
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

  List<WhatsappStatus> _filterMediaFiles(
    List<FileSystemEntity> entities, {
    bool includeVideos = false,
    bool includeImages = false,
  }) {
    final List<WhatsappStatus> filteredFiles = [];

    for (var entity in entities) {
      if (entity is File) {
        final path = entity.path;
        final extension = path.split('.').last.toLowerCase();

        if (includeImages && (extension == 'jpg' || extension == 'png')) {
          filteredFiles.add(WhatsappStatus(file: entity));
        }

        if (includeVideos && extension == 'mp4') {
          filteredFiles.add(WhatsappStatus(file: entity));
        }
      }
    }

    return filteredFiles;
  }
}
