import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoGrid extends StatefulWidget {
  const VideoGrid({super.key, required this.video});
  final File video;

  @override
  State<VideoGrid> createState() => _VideoGridState();
}

class _VideoGridState extends State<VideoGrid> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.video)
      ..addListener(() {
        setState(() {});
      })
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? GestureDetector(
            onTap: () {},
            onPanDown: (_) {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
                _controller.value.isPlaying
                    ? const SizedBox()
                    : const Icon(
                        Icons.play_arrow,
                        // size: 100,
                        color: Colors.white,
                      ),
              ],
            ),
          )
        : const SizedBox();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
