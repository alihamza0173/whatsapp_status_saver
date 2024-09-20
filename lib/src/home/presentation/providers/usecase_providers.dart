import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_status_saver/src/home/domain/usecases/get_image_status_usecase.dart';
import 'package:whatsapp_status_saver/src/home/domain/usecases/get_saved_status_usecase.dart';
import 'package:whatsapp_status_saver/src/home/domain/usecases/get_video_status_usecase.dart';
import 'package:whatsapp_status_saver/src/home/domain/usecases/save_status_usecase.dart';
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

final saveSavedStatusUseCaseProvider = Provider<SaveStatusUsecase>((ref) {
  final whatsappStatusRepository = ref.read(whatsappRepositoryProvider);
  return SaveStatusUsecase(whatsappStatusRepository);
});
