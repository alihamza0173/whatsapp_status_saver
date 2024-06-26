import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_status_saver/application/providers/file_manager_provider.dart';
import 'package:whatsapp_status_saver/application/providers/full_screen_media_provider.dart';
import 'package:whatsapp_status_saver/application/providers/settings_provider.dart';
import 'package:whatsapp_status_saver/application/router/app_routes.dart';
import 'package:whatsapp_status_saver/presentation/common/no_media_available.dart';
import 'package:whatsapp_status_saver/presentation/home_page/ui/saved_status_tab/ui/grid_child.dart';

class VideosTab extends StatelessWidget {
  const VideosTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dir = context.watch<SettingsProvider>().statusDirectory;
    return FutureBuilder(
        future: fileManagerProvider.getFilesVideosThumbnail(dir),
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
                          return GestureDetector(
                            onTap: () {
                              fullScreenMediaProvider.setMedia(
                                  data, data.indexOf(e), false);
                              context.push(AppRoutes.fullScreenVideo);
                            },
                            child: GridChild(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.memory(e.first!),
                                  const Icon(
                                    Icons.play_arrow,
                                    // size: 50.0,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                : const NoMediaAvailable(
                    type: 'Videos',
                    icon: Icons.video_collection_outlined,
                  );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
