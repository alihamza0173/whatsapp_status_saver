import 'dart:io';

import 'package:whatsapp_status_saver/src/home/domain/entities/whatsapp_status.dart';

abstract class WhatsappStatusRepository {
  Future<List<WhatsappStatus>> getImageStatus(
    Directory directory,
  );

  Future<List<WhatsappStatus>> getVideoStatus(
    Directory directory,
  );

  Future<List<WhatsappStatus>> getSavedStatus(
    Directory directory,
  );

  Future<void> saveStatus(
    Directory directory,
    File file,
  );
}
