import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsapp_status_saver/application/providers/file_manager_provider.dart';
import 'package:whatsapp_status_saver/application/providers/full_screen_video_provider.dart';
import 'package:whatsapp_status_saver/application/router/app_routes.dart';
import 'package:whatsapp_status_saver/presentation/home_page/ui/videos_tab/video_grid.dart';

class StatusSaverVideos extends StatelessWidget {
  const StatusSaverVideos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: fileManagerProvider.getFilesVidos(),
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
                  children: data
                      .map((e) => GestureDetector(
                            onTap: () {
                              fullScreenVideoProvider.index = data.indexOf(e);
                              fullScreenVideoProvider.videos = data;
                              context.push(AppRoutes.fullScreenVideo);
                            },
                            child: VideoGrid(video: e as File),
                          ))
                      .toList(),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
