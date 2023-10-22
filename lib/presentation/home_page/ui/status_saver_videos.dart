import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:whatsapp_status_saver/application/providers/file_manager_provider.dart';
import 'package:whatsapp_status_saver/presentation/home_page/ui/video_grid.dart';

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
                padding: const EdgeInsets.all(8.0),
                child: StaggeredGrid.count(
                  crossAxisCount: 2,
                  axisDirection: AxisDirection.down,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  children:
                      data.map((e) => VideoGrid(video: e as File)).toList(),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
