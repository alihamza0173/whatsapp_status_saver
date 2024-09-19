import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_status_saver/application/common/directories.dart';
import 'package:whatsapp_status_saver/application/providers/file_manager_provider.dart';
import 'package:whatsapp_status_saver/src/saved_status/data/saved_status_datasource.dart';

final savedStatusDataSourceProvider = Provider<SavedStatusDataSource>((ref) {
  return SavedStatusDataSource();
});

final savedStatusesProvider =
    FutureProvider<List<Pair<Uint8List?, FileSystemEntity>>>((ref) async {
  final savedStatusDataSource = ref.watch(savedStatusDataSourceProvider);
  return savedStatusDataSource.getSavedStatusesWithThumbnails(savedStatusDir);
});
