import 'dart:io';

import 'package:flutter/widgets.dart';

class FullScreenImageProvider extends ChangeNotifier {
  bool isStatusSaved = false;
  int index = 0;
  List<FileSystemEntity> images = [];
}

final fullScreenImageProvider = FullScreenImageProvider();
