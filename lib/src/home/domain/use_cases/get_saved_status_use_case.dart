import 'dart:io';

import 'package:whatsapp_status_saver/src/home/domain/entities/whatsapp_status.dart';
import 'package:whatsapp_status_saver/src/home/domain/repositories/whatsapp_status_repository.dart';

class GetSavedStatusUseCase {
  final WhatsappStatusRepository whatsappStatusRepository;
  const GetSavedStatusUseCase(this.whatsappStatusRepository);

  Future<List<WhatsappStatus>> execute(
    Directory directory,
  ) async {
    return await whatsappStatusRepository.getSavedStatus(directory);
  }
}
