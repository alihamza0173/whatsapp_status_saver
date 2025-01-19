import 'dart:io';
import 'package:whatsapp_status_saver/src/home/domain/entities/whatsapp_status.dart';
import 'package:whatsapp_status_saver/src/home/domain/repositories/whatsapp_status_repository.dart';

class GetVideoStatusUseCase {
  final WhatsappStatusRepository whatsappStatusRepository;
  const GetVideoStatusUseCase(this.whatsappStatusRepository);

  Future<List<WhatsappStatus>> execute(
    Directory directory,
  ) async {
    return await whatsappStatusRepository.getVideoStatus(directory);
  }
}
