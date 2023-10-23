import 'dart:io';

import 'package:flutter/widgets.dart';

class FullScreenImageProvider extends ChangeNotifier {
  int index = 0;
  List<FileSystemEntity> images = [];
}

final fullScreenImageProvider = FullScreenImageProvider();
