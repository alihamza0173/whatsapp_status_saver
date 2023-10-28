import 'dart:io';

class FullScreenMediaProvider {
  bool isStatusSaved = false;
  int index = 0;
  List<FileSystemEntity> media = [];

  void setMedia(List<FileSystemEntity> media, int index, bool isStatusSaved) {
    this.media = media;
    this.index = index;
    this.isStatusSaved = isStatusSaved;
  }
}

final fullScreenMediaProvider = FullScreenMediaProvider();
