import 'dart:io';

import 'package:flutter/widgets.dart';

class FullScreenMediaProvider extends ChangeNotifier {
  bool isStatusSaved = false;
  int index = 0;
  List<FileSystemEntity> media = [];
}

final fullScreenMediaProvider = FullScreenMediaProvider();
