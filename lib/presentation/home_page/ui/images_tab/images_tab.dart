import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsapp_status_saver/application/providers/file_manager_provider.dart';
import 'package:whatsapp_status_saver/application/providers/full_screen_media_provider.dart';
import 'package:whatsapp_status_saver/application/router/app_routes.dart';

class ImagesTab extends StatelessWidget {
  const ImagesTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fileManagerProvider.getFilesImages(),
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
                              fullScreenMediaProvider.setMedia(
                                  data, data.indexOf(e), false);
                              context.push(AppRoutes.fullScreenImage);
                            },
                            child: Hero(
                              tag: 'image${data.indexOf(e)}',
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.file(e as File),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            );
            // return GridView.builder(
            //   itemCount: data.length,nm,.
            //   padding: const EdgeInsets.all(8.0),
            //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 2,
            //     mainAxisSpacing: 8.0,
            //     crossAxisSpacing: 8.0,
            //   ),
            //   itemBuilder: (context, index) {
            //     final file = data[index];
            //     return DecoratedBox(
            //       decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.circular(8.0),
            //         image: DecorationImage(
            //           image: FileImage(file as File),
            //           fit: BoxFit.scaleDown,
            //         ),
            //       ),
            //     );
            //   },
            // );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
