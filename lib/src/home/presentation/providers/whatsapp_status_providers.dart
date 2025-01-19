import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_status_saver/core/enums/status_directory.dart';
import 'package:whatsapp_status_saver/src/home/domain/entities/pair.dart';
import 'package:whatsapp_status_saver/src/home/presentation/providers/use_case_providers.dart';
import 'package:whatsapp_status_saver/src/settings/providers/settings_provider.dart';

final imageStatusProvider =
    FutureProvider<List<Pair<Uint8List?, FileSystemEntity>>>((ref) {
  final directory = ref.watch(settingsProvider).statusDirectory;
  return ref.read(getImageStatusUseCaseProvider).execute(directory);
});

final videoStatusProvider =
    FutureProvider<List<Pair<Uint8List?, FileSystemEntity>>>((ref) async {
  final directory = ref.watch(settingsProvider).statusDirectory;
  return ref.read(getVideoStatusUseCaseProvider).execute(directory);
});

final savedStatusProvider =
    FutureProvider<List<Pair<Uint8List?, FileSystemEntity>>>((ref) async {
  return ref.read(getSavedStatusUseCaseProvider).execute(
        StatusDirectory.savedStatus.directory,
      );
});
