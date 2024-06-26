import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:whatsapp_status_saver/application/providers/file_manager_provider.dart';
import 'package:whatsapp_status_saver/application/providers/full_screen_media_provider.dart';
import 'package:whatsapp_status_saver/presentation/common/status_saver_options_button.dart';

class FullscreenImageView extends StatefulWidget {
  const FullscreenImageView({super.key});

  @override
  State<FullscreenImageView> createState() => _FullscreenImageViewState();
}

class _FullscreenImageViewState extends State<FullscreenImageView> {
  late final PageController _pageController;
  late final List<Pair<Uint8List?, FileSystemEntity>> images;
  late final int initialIndex;

  @override
  void initState() {
    images = fullScreenMediaProvider.media;
    initialIndex = fullScreenMediaProvider.index;
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
          final image = images[pageIndex].second as File;
          return Stack(
            alignment: Alignment.center,
            children: [
              InteractiveViewer(
                clipBehavior: Clip.none,
                child: Hero(
                  tag: 'image$pageIndex',
                  child: Image.file(image, fit: BoxFit.contain),
                ),
              ),
              StatusSaverOptionsButton(
                file: image,
                isSaved: fullScreenMediaProvider.isStatusSaved,
              ),
            ],
          );
        },
      ),
    );
  }
}
