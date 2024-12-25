import 'dart:io';
import 'dart:typed_data';

import 'package:whatsapp_status_saver/src/home/domain/entities/pair.dart';

abstract class WhatsappStatusRepository {
  Future<List<Pair<Uint8List?, FileSystemEntity>>> getImageStatus(
    Directory directory,
  );

  Future<List<Pair<Uint8List?, FileSystemEntity>>> getVideoStatus(
    Directory directory,
  );

  Future<List<Pair<Uint8List?, FileSystemEntity>>> getSavedStatus(
    Directory directory,
  );

  Future<void> saveStatus(
    Directory directory,
    File file,
  );
}
