import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class GridVideo extends StatefulWidget {
  const GridVideo({super.key, required this.video});
  final File video;

  @override
  State<GridVideo> createState() => _GridVideoState();
}

class _GridVideoState extends State<GridVideo> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.file(widget.video)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _controller?.value.isInitialized ?? false
        ? Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: VideoPlayer(_controller!),
              ),
              _controller!.value.isPlaying
                  ? const SizedBox()
                  : const Icon(
                      Icons.play_arrow,
                      // size: 100,
                      color: Colors.white,
                    ),
            ],
          )
        : const SizedBox();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
