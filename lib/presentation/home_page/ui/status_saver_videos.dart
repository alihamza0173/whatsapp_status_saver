import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:whatsapp_status_saver/application/providers/file_manager_provider.dart';

class StatusSaverVideos extends StatelessWidget {
  const StatusSaverVideos({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: fileManagerProvider.getVideoFiles(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StaggeredGrid.count(
                crossAxisCount: 2,
                axisDirection: AxisDirection.down,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                children: data != null
                    ? data
                        .map(
                          (e) => ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: FutureBuilder(
                              future: e,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final data = snapshot.data;
                                  return Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.memory(data!),
                                      const Icon(
                                        Icons.play_arrow,
                                        size: 50.0,
                                        color: Colors.white,
                                      ),
                                    ],
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                          ),
                        )
                        .toList()
                    : [const Center(child: Text('No videos found'))],
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
