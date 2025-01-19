import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_status_saver/src/home/domain/entities/whatsapp_status.dart';
import 'package:whatsapp_status_saver/src/status_preview/providers/full_screen_media_provider.dart';
import 'package:whatsapp_status_saver/shared/presentation/widgets/status_saver_options_button.dart';

class FullscreenImageView extends ConsumerStatefulWidget {
  const FullscreenImageView({super.key});

  @override
  ConsumerState<FullscreenImageView> createState() =>
      _FullscreenImageViewState();
}

class _FullscreenImageViewState extends ConsumerState<FullscreenImageView> {
  late final PageController _pageController;
  late final List<WhatsappStatus> images;
  late final int initialIndex;
  late final FullScreenMediaProvider notifier;

  @override
  void initState() {
    notifier = ref.read(fullScreenMediaProvider);
    images = notifier.media;
    initialIndex = notifier.index;
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
        itemBuilder: (final _, final index) {
          final image = images[index].file as File;
          return Stack(
            alignment: Alignment.center,
            children: [
              InteractiveViewer(
                clipBehavior: Clip.none,
                child: Image.file(image, fit: BoxFit.contain),
              ),
              StatusSaverOptionsButton(
                file: image,
                isSaved: notifier.isStatusSaved,
              ),
            ],
          );
        },
      ),
    );
  }
}
