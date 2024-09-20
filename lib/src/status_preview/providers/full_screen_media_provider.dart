import 'dart:io';
import 'dart:typed_data';

import 'package:whatsapp_status_saver/src/home/domain/entities/pair.dart';

class FullScreenMediaProvider {
  bool isStatusSaved = false;
  int index = 0;
  List<Pair<Uint8List?, FileSystemEntity>> media = [];

  void setMedia(
    List<Pair<Uint8List?, FileSystemEntity>> media,
    int index,
    bool? isStatusSaved,
  ) {
    this.media = media;
    this.index = index;
    this.isStatusSaved = isStatusSaved ?? this.isStatusSaved;
  }
}

final fullScreenMediaProvider = FullScreenMediaProvider();
