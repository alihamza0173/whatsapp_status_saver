import 'dart:developer';
import 'dart:io';
import 'package:saf/saf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_status_saver/application/common/directories.dart';
import 'package:whatsapp_status_saver/src/onboarding/presentation/states/onboarding_state.dart';

final onBoardingProvider =
    StateNotifierProvider<OnboardingNotifier, OnBoardingState>(
  (ref) => OnboardingNotifier()..checkPermission(),
);

class OnboardingNotifier extends StateNotifier<OnBoardingState> {
  OnboardingNotifier() : super(OnBoardingState());

  Future<void> checkPermission() async {
    final status = await Permission.storage.status;

    if (status.isGranted) {
      Directory? directory;
      bool permissionGranted = false;

      // Check for WhatsApp or WhatsApp Business directories
      if (await whatsappStatusDir.exists()) {
        directory = whatsappStatusDir;
      } else if (await whatsappBzStatusDir.exists()) {
        directory = whatsappBzStatusDir;
      }

      if (directory != null) {
        final String relativePath = _getRelativePath(directory.path);
        final Saf saf = Saf(relativePath);

        // SAF handles the directory permission for Android 11+
        permissionGranted = await saf.getDirectoryPermission() ?? false;
        log('is permission granted to $relativePath? $permissionGranted');
      }

      state = state.copyWith(
        isStoragePermissionAllowed: status.isGranted,
        isWhatsappPermissionAllowed:
            permissionGranted && directory == whatsappStatusDir,
        isWhatsappBznsPermissionAllowed:
            permissionGranted && directory == whatsappBzStatusDir,
      );
    } else {
      state = state.copyWith(
        isStoragePermissionAllowed: false,
      );
    }
  }

  // Helper function to get the relative path starting from Android/
  String _getRelativePath(String fullPath) {
    final startIndex = fullPath.indexOf('Android');
    return startIndex != -1 ? fullPath.substring(startIndex) : fullPath;
  }

  // Function to request storage permission and directory access on user tap
  Future<void> requestPermission() async {
    final storageStatus = await Permission.storage.request();

    if (storageStatus.isGranted) {
      await checkPermission();
    } else if (storageStatus.isPermanentlyDenied) {
      await openAppSettings();
      state = state.copyWith(isStoragePermissionAllowed: false);
    } else if (storageStatus.isDenied) {
      state = state.copyWith(isStoragePermissionAllowed: false);
    }
  }

  Future<void> requestDirectoryAccess(Directory directory) async {
    final storageStatus = await Permission.storage.request();

    if (storageStatus.isGranted) {
      final String relativePath = _getRelativePath(directory.path);
      final Saf saf = Saf(relativePath);
      final bool isPermissionGranted =
          await saf.getDirectoryPermission() ?? false;

      if (isPermissionGranted && directory == whatsappStatusDir) {
        state = state.copyWith(
          isWhatsappPermissionAllowed: true,
        );
      } else if (isPermissionGranted && directory == whatsappBzStatusDir) {
        state = state.copyWith(
          isWhatsappBznsPermissionAllowed: true,
        );
      }
    } else if (storageStatus.isPermanentlyDenied) {
      await openAppSettings();
    }
  }
}
