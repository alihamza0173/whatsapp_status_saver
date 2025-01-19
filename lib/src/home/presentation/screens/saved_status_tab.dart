import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsapp_status_saver/src/home/domain/entities/whatsapp_status.dart';
import 'package:whatsapp_status_saver/src/status_preview/providers/full_screen_media_provider.dart';
import 'package:whatsapp_status_saver/router/app_routes.dart';
import 'package:whatsapp_status_saver/src/home/presentation/providers/whatsapp_status_providers.dart';
import 'package:whatsapp_status_saver/shared/presentation/widgets/grid_child.dart';

class SavedStatusTab extends ConsumerWidget {
  const SavedStatusTab({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedStatusesState = ref.watch(savedStatusProvider);

    final List<WhatsappStatus> images = [];
    final List<WhatsappStatus> videos = [];

    return savedStatusesState.when(
      data: (data) {
        if (data.isNotEmpty) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: StaggeredGrid.count(
                crossAxisCount: 2,
                axisDirection: AxisDirection.down,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
                children: data.map((status) {
                  final extension = status.file.path.split('.').last;
                  bool isVideo = false;

                  // Separate images and videos
                  if (extension == 'jpg' || extension == 'png') {
                    images.add(status);
                  }
                  if (extension == 'mp4') {
                    videos.add(status);
                    isVideo = true;
                  }

                  // Return GridChild for display
                  return GridChild(
                    onTap: () {
                      final notifier = ref.read(fullScreenMediaProvider);
                      if (isVideo) {
                        notifier.setMedia(
                          videos,
                          videos.indexOf(status),
                          true,
                        );
                        context.push(AppRoutes.fullScreenVideo);
                      } else {
                        notifier.setMedia(
                          images,
                          images.indexOf(status),
                          true,
                        );
                        context.push(AppRoutes.fullScreenImage);
                      }
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        isVideo
                            ? Image.memory(status.thumbnail!)
                            : Image.file(status.file as File),
                        if (isVideo)
                          const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        } else {
          // No saved statuses available
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.save_alt_outlined, color: Colors.green),
                Text(
                  'No Saved Status Available Now',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.green),
                ),
              ],
            ),
          );
        }
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text('Error: $error'),
      ),
    );
  }
}
