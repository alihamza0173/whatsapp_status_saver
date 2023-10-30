import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsapp_status_saver/application/providers/file_manager_provider.dart';
import 'package:whatsapp_status_saver/application/providers/full_screen_media_provider.dart';
import 'package:whatsapp_status_saver/application/router/app_routes.dart';
import 'package:whatsapp_status_saver/presentation/home_page/ui/saved_status_tab/ui/grid_child.dart';
import 'package:whatsapp_status_saver/presentation/home_page/ui/videos_tab/grid_video.dart';

class SavedStatusTab extends StatelessWidget {
  const SavedStatusTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<FileSystemEntity> images = [];
    final List<FileSystemEntity> videos = [];
    return FutureBuilder(
        future: fileManagerProvider.getSavedStatus(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data as List<FileSystemEntity>;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: StaggeredGrid.count(
                  crossAxisCount: 2,
                  axisDirection: AxisDirection.down,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                  children: data.map((e) {
                    final extension = e.path.split('.').last;
                    if (extension == 'jpg' || extension == 'png') {
                      images.add(e);
                      return GridChild(
                        onTap: () {
                          fullScreenMediaProvider.setMedia(
                              images, images.indexOf(e), true);
                          context.push(AppRoutes.fullScreenImage);
                        },
                        child: Hero(
                            tag: 'image${images.indexOf(e)}',
                            child: Image.file(e as File)),
                      );
                    } else if (extension == 'mp4') {
                      videos.add(e);
                      return GridChild(
                        onTap: () {
                          fullScreenMediaProvider.setMedia(
                              videos, videos.indexOf(e), true);
                          context.push(AppRoutes.fullScreenVideo);
                        },
                        child: GridVideo(video: e as File),
                      );
                    } else {
                      return const SizedBox();
                    }
                  }).toList(),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
