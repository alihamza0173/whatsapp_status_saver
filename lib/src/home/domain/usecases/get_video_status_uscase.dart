import 'dart:io';
import 'dart:typed_data';

import 'package:whatsapp_status_saver/src/home/domain/entities/pair.dart';
import 'package:whatsapp_status_saver/src/home/domain/repositories/whatsapp_status_repository.dart';

class GetImageStatusUseCase {
  final WhatsappStatusRepository whatsappStatusRepository;
  const GetImageStatusUseCase(this.whatsappStatusRepository);

  Future<List<Pair<Uint8List?, FileSystemEntity>>> execute(
    Directory directory,
  ) async {
    return await whatsappStatusRepository.getVideoStatus(directory);
  }
}
