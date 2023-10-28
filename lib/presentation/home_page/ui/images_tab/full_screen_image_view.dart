import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsapp_status_saver/application/providers/full_screen_image_provider.dart';
import 'package:whatsapp_status_saver/presentation/common/status_saver_options_button.dart';

class FullscreenImageView extends StatefulWidget {
  const FullscreenImageView({super.key});

  @override
  State<FullscreenImageView> createState() => _FullscreenImageViewState();
}

class _FullscreenImageViewState extends State<FullscreenImageView> {
  late final PageController _pageController;
  late final List<FileSystemEntity> images;
  late final int initialIndex;

  @override
  void initState() {
    images = fullScreenImageProvider.images;
    initialIndex = fullScreenImageProvider.index;
    _pageController = PageController(initialPage: initialIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black),
      body: PageView.builder(
        controller: _pageController,
        itemCount: images.length,
        itemBuilder: (context, pageIndex) {
          final image = images[pageIndex] as File;
          return Stack(
            alignment: Alignment.center,
            children: [
              InteractiveViewer(
                clipBehavior: Clip.none,
                child: Image.file(image, fit: BoxFit.contain),
              ),
              StatusSaverOptionsButton(file: image),
            ],
          );
        },
      ),
    );
  }
}
