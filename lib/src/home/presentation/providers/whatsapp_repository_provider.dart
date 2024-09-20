import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_status_saver/src/home/data/repositories/whatsapp_status_repository_impl.dart';
import 'package:whatsapp_status_saver/src/home/domain/repositories/whatsapp_status_repository.dart';

final whatsappRepositoryProvider = Provider<WhatsappStatusRepository>((ref) {
  return WhatsappStatusRepositoryImpl();
});
