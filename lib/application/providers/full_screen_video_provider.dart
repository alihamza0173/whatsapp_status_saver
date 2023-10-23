import 'dart:io';

import 'package:flutter/widgets.dart';

class FullScreenVideoProvider extends ChangeNotifier {
  int index = 0;
  List<FileSystemEntity> videos = [];
}

final fullScreenVideoProvider = FullScreenVideoProvider();
