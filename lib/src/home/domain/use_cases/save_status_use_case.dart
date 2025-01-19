import 'dart:io';

import 'package:whatsapp_status_saver/src/home/domain/repositories/whatsapp_status_repository.dart';

class SaveStatusUseCase {
  final WhatsappStatusRepository whatsappStatusRepository;

  const SaveStatusUseCase(this.whatsappStatusRepository);

  Future<void> execute(
    Directory directory,
    File file,
  ) async {
    return await whatsappStatusRepository.saveStatus(directory, file);
  }
}
