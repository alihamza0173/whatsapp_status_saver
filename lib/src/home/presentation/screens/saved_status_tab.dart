import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsapp_status_saver/src/status_preview/providers/full_screen_media_provider.dart';
import 'package:whatsapp_status_saver/router/app_routes.dart';
import 'package:whatsapp_status_saver/src/home/presentation/providers/saved_status_provider.dart';
import 'package:whatsapp_status_saver/shared/presentation/widgets/grid_child.dart';
import 'package:whatsapp_status_saver/src/home/domain/entities/pair.dart';

class SavedStatusTab extends ConsumerWidget {
  const SavedStatusTab({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedStatusesState = ref.watch(savedStatuseProvider);

    final List<Pair<Uint8List?, FileSystemEntity>> images = [];
    final List<Pair<Uint8List?, FileSystemEntity>> videos = [];

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
                children: data.map((e) {
                  final extension = e.second.path.split('.').last;
                  bool isVideo = false;

                  // Separate images and videos
                  if (extension == 'jpg' || extension == 'png') {
                    images.add(e);
                  }
                  if (extension == 'mp4') {
                    videos.add(e);
                    isVideo = true;
                  }

                  // Return GridChild for display
                  return GridChild(
                    onTap: () {
                      if (isVideo) {
                        fullScreenMediaProvider.setMedia(
                          videos,
                          videos.indexOf(e),
                          true,
                        );
                        context.push(AppRoutes.fullScreenVideo);
                      } else {
                        fullScreenMediaProvider.setMedia(
                          images,
                          images.indexOf(e),
                          true,
                        );
                        context.push(AppRoutes.fullScreenImage);
                      }
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        isVideo
                            ? Image.memory(e.first!)
                            : Image.file(e.second as File),
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
