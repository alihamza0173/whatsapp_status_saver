import 'dart:io';

class FullScreenMediaProvider {
  bool isStatusSaved = false;
  int index = 0;
  List<FileSystemEntity> media = [];
}

final fullScreenMediaProvider = FullScreenMediaProvider();
