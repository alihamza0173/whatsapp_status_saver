import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_status_saver/core/enums/status_directory.dart';
import 'package:whatsapp_status_saver/src/onboarding/presentation/states/onboarding_state.dart';

final onBoardingProvider =
    StateNotifierProvider<OnboardingNotifier, OnBoardingState>(
  (ref) => OnboardingNotifier(),
);

class OnboardingNotifier extends StateNotifier<OnBoardingState> {
  OnboardingNotifier() : super(OnBoardingState()) {
    checkPermission();
  }

  Future<Directory?> _getExistingWhatsappDirectory() async {
    for (var dir in StatusDirectory.values) {
      final directory = dir.directory;
      if (await directory.exists()) {
        return directory;
      }
    }
    return null;
  }

  Future<void> checkPermission() async {
    final status = await Permission.manageExternalStorage.status;

    if (status.isGranted) {
      final directory = await _getExistingWhatsappDirectory();

      state = state.copyWith(
        isStoragePermissionAllowed: true,
        isWhatsappPermissionAllowed:
            directory == StatusDirectory.whatsapp.directory,
        isWhatsappBznsPermissionAllowed:
            directory == StatusDirectory.whatsappBusiness.directory,
      );
    } else {
      state = state.copyWith(
        isStoragePermissionAllowed: false,
      );
    }
  }

  // Request permission and handle the different cases.
  Future<void> requestPermission() async {
    final storageStatus = await Permission.manageExternalStorage.request();

    if (storageStatus.isGranted) {
      await checkPermission();
    } else if (storageStatus.isPermanentlyDenied) {
      await openAppSettings();
      state = state.copyWith(isStoragePermissionAllowed: false);
    } else {
      state = state.copyWith(isStoragePermissionAllowed: false);
    }
  }
}
