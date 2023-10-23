import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsapp_status_saver/application/providers/full_screen_video_provider.dart';
import 'package:whatsapp_status_saver/presentation/home_page/ui/full_screen_video.dart';

class FullscreenVideoViewer extends StatefulWidget {
  const FullscreenVideoViewer({super.key});

  @override
  State<FullscreenVideoViewer> createState() => _FullscreenImageViewerState();
}

class _FullscreenImageViewerState extends State<FullscreenVideoViewer> {
  late final PageController _pageController;
  late final List<FileSystemEntity> videos;
  late final int initialIndex;

  @override
  void initState() {
    super.initState();
    videos = fullScreenVideoProvider.videos;
    initialIndex = fullScreenVideoProvider.index;
    _pageController = PageController(initialPage: initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: videos.length,
        itemBuilder: (context, pageIndex) {
          return FullScreenVideo(video: videos[pageIndex] as File);
        },
      ),
    );
  }
}
