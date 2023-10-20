import 'dart:io';

import 'package:flutter/widgets.dart';

class FullScreenImagePreview extends ChangeNotifier {
  int index = 0;
  List<FileSystemEntity> images = [];
}

final fullScreenImagePreviewProvider = FullScreenImagePreview();
