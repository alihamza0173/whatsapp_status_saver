import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_status_saver/application/common/directories.dart';
import 'package:whatsapp_status_saver/src/home/domain/entities/pair.dart';
import 'package:whatsapp_status_saver/src/home/presentation/providers/usecase_providers.dart';

final savedStatuseProvider =
    FutureProvider<List<Pair<Uint8List?, FileSystemEntity>>>((ref) async {
  return ref.read(getSavedStatusUseCaseProvider).execute(savedStatusDir);
});
