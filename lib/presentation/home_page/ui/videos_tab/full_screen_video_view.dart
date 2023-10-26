import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsapp_status_saver/application/providers/file_manager_provider.dart';
import 'package:whatsapp_status_saver/application/providers/full_screen_video_provider.dart';
import 'package:whatsapp_status_saver/presentation/home_page/ui/videos_tab/full_screen_video.dart';
import 'package:whatsapp_status_saver/presentation/common/status_saver_options_button.dart';

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
    videos = fullScreenVideoProvider.videos;
    initialIndex = fullScreenVideoProvider.index;
    _pageController = PageController(initialPage: initialIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
      appBar: AppBar(backgroundColor: Colors.black),
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: videos.length,
        itemBuilder: (context, pageIndex) {
          final video = videos[pageIndex] as File;
          return Stack(
            alignment: Alignment.center,
            children: [
              FullScreenVideo(video: video),
              StatusSaverOptionsButton(
                onSavePressed: () async {
                  final result = await fileManagerProvider.saveStatus(video);
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
