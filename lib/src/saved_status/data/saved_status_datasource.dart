import 'dart:io';
import 'dart:typed_data';

import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:whatsapp_status_saver/application/common/directories.dart';
import 'package:whatsapp_status_saver/application/providers/file_manager_provider.dart';

class SavedStatusDataSource {
  Future<List<Pair<Uint8List?, FileSystemEntity>>>
      getSavedStatusesWithThumbnails(Directory dir) async {
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
}
