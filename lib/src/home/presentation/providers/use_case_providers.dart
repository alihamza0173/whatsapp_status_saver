import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_status_saver/src/home/domain/use_cases/get_image_status_use_case.dart';
import 'package:whatsapp_status_saver/src/home/domain/use_cases/get_saved_status_use_case.dart';
import 'package:whatsapp_status_saver/src/home/domain/use_cases/get_video_status_use_case.dart';
import 'package:whatsapp_status_saver/src/home/domain/use_cases/save_status_use_case.dart';
import 'package:whatsapp_status_saver/src/home/presentation/providers/whatsapp_repository_provider.dart';

final getImageStatusUseCaseProvider = Provider<GetImageStatusUseCase>((ref) {
  final whatsappStatusRepository = ref.read(whatsappRepositoryProvider);
  return GetImageStatusUseCase(whatsappStatusRepository);
});

final getVideoStatusUseCaseProvider = Provider<GetVideoStatusUseCase>((ref) {
  final whatsappStatusRepository = ref.read(whatsappRepositoryProvider);
  return GetVideoStatusUseCase(whatsappStatusRepository);
});

final getSavedStatusUseCaseProvider = Provider<GetSavedStatusUseCase>((ref) {
  final whatsappStatusRepository = ref.read(whatsappRepositoryProvider);
  return GetSavedStatusUseCase(whatsappStatusRepository);
});

final saveSavedStatusUseCaseProvider = Provider<SaveStatusUseCase>((ref) {
  final whatsappStatusRepository = ref.read(whatsappRepositoryProvider);
  return SaveStatusUseCase(whatsappStatusRepository);
});
