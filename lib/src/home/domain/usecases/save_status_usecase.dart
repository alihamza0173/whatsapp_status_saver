import 'dart:io';

import 'package:whatsapp_status_saver/src/home/domain/repositories/whatsapp_status_repository.dart';

class SaveStatusUsecase {
  final WhatsappStatusRepository whatsappStatusRepository;

  const SaveStatusUsecase(this.whatsappStatusRepository);

  Future<String> execute(
    Directory directory,
    File file,
  ) async {
    return await whatsappStatusRepository.saveStatus(directory, file);
  }
}
