import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsapp_status_saver/application/providers/full_screen_image_provider.dart';

class FullscreenImageViewer extends StatefulWidget {
  const FullscreenImageViewer({super.key});

  @override
  State<FullscreenImageViewer> createState() => _FullscreenImageViewerState();
}

class _FullscreenImageViewerState extends State<FullscreenImageViewer> {
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
          return InteractiveViewer(
            child: Image.file(
              images[pageIndex] as File,
              fit: BoxFit.contain,
            ),
          );
        },
      ),
    );
  }
}
