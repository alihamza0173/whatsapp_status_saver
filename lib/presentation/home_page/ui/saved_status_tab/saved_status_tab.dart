import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:whatsapp_status_saver/application/providers/file_manager_provider.dart';
import 'package:whatsapp_status_saver/presentation/home_page/ui/videos_tab/grid_video.dart';

class SavedStatusTab extends StatelessWidget {
  const SavedStatusTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: fileManagerProvider.getSavedStatus(),
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
                    final path = e.path;
                    final extension = path.split('.').last;
                    if (extension == 'jpg' || extension == 'png') {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.file(e as File),
                      );
                    } else if (extension == 'mp4') {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
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
