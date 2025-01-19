import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsapp_status_saver/src/home/presentation/providers/whatsapp_status_providers.dart';
import 'package:whatsapp_status_saver/src/status_preview/providers/full_screen_media_provider.dart';
import 'package:whatsapp_status_saver/router/app_routes.dart';
import 'package:whatsapp_status_saver/shared/presentation/widgets/no_media_available.dart';

class ImageStatus extends ConsumerWidget {
  const ImageStatus({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageStatus = ref.watch(imageStatusProvider);

    return imageStatus.when(
      data: (data) {
        return data.isNotEmpty
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: StaggeredGrid.count(
                    crossAxisCount: 2,
                    axisDirection: AxisDirection.down,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                    children: data
                        .map((status) => GestureDetector(
                              onTap: () {
                                ref.read(fullScreenMediaProvider).setMedia(
                                    data, data.indexOf(status), false);
                                context.push(AppRoutes.fullScreenImage);
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.file(status.file as File),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              )
            : const NoMediaAvailable(
                type: 'Images',
                icon: Icons.image_not_supported_outlined,
              );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
