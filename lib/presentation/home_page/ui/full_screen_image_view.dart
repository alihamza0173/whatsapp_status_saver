import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsapp_status_saver/application/providers/file_manager_provider.dart';
import 'package:whatsapp_status_saver/application/providers/full_screen_image_provider.dart';
import 'package:whatsapp_status_saver/presentation/home_page/ui/status_saver_options_button.dart';

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
          final image = images[pageIndex] as File;
          return Stack(
            alignment: Alignment.center,
            children: [
              InteractiveViewer(
                clipBehavior: Clip.none,
                child: Image.file(image, fit: BoxFit.contain),
              ),
              StatusSaverOptionsButton(
                onSavePressed: () async {
                  final result = await fileManagerProvider.saveStus(image);
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(result)),
                  );
                },
                onSharePressed: () {},
              ),
            ],
          );
        },
      ),
    );
  }
}
