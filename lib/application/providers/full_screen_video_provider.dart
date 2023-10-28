import 'dart:io';

import 'package:flutter/widgets.dart';

class FullScreenVideoProvider extends ChangeNotifier {
  bool isStatusSaved = false;
  int index = 0;
  List<FileSystemEntity> videos = [];
}

final fullScreenVideoProvider = FullScreenVideoProvider();
