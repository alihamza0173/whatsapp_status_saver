import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsapp_status_saver/application/providers/file_manager_provider.dart';
import 'package:whatsapp_status_saver/application/providers/full_screen_media_provider.dart';
import 'package:whatsapp_status_saver/application/router/app_routes.dart';
import 'package:whatsapp_status_saver/presentation/home_page/ui/saved_status_tab/ui/grid_child.dart';

class SavedStatusTab extends StatelessWidget {
  const SavedStatusTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<Pair<Uint8List?, FileSystemEntity>> images = [];
    final List<Pair<Uint8List?, FileSystemEntity>> videos = [];
    return FutureBuilder(
        future: fileManagerProvider.getSavedStatusesWithThumbnails(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return data!.isNotEmpty
                ? SingleChildScrollView(
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
                          if (extension == 'jpg' || extension == 'png') {
                            images.add(e);
                          }
                          if (extension == 'mp4') {
                            videos.add(e);
                            isVideo = true;
                          }
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
                                  videos.indexOf(e),
                                  true,
                                );
                                context.push(AppRoutes.fullScreenImage);
                              }
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Hero(
                                  tag: 'image${data.indexOf(e)}',
                                  child: isVideo
                                      ? Image.memory(e.first!)
                                      : Image.file(e.second as File),
                                ),
                                if (isVideo)
                                  const Icon(
                                    Icons.play_arrow,
                                    // size: 50.0,
                                    color: Colors.white,
                                  ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                : Column(
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
                  );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
