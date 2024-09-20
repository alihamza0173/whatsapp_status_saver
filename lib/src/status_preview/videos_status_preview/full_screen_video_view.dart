import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_status_saver/src/status_preview/providers/full_screen_media_provider.dart';
import 'package:whatsapp_status_saver/shared/presentation/widgets/status_saver_options_button.dart';
import 'package:whatsapp_status_saver/src/home/domain/entities/pair.dart';
import 'package:whatsapp_status_saver/src/status_preview/videos_status_preview/full_screen_video.dart';

class FullscreenVideoViewer extends ConsumerStatefulWidget {
  const FullscreenVideoViewer({super.key});

  @override
  ConsumerState<FullscreenVideoViewer> createState() =>
      _FullscreenImageViewerState();
}

class _FullscreenImageViewerState extends ConsumerState<FullscreenVideoViewer> {
  late final PageController _pageController;
  late final List<Pair<Uint8List?, FileSystemEntity>> videos;
  late final int initialIndex;
  late final FullScreenMediaProvider notifier;

  @override
  void initState() {
    notifier = ref.read(fullScreenMediaProvider);
    videos = notifier.media;
    initialIndex = notifier.index;
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
          final video = videos[pageIndex].second as File;
          return Stack(
            alignment: Alignment.center,
            children: [
              FullScreenVideo(video: video),
              StatusSaverOptionsButton(
                file: video,
                isSaved: notifier.isStatusSaved,
              ),
            ],
          );
        },
      ),
    );
  }
}
