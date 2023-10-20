import 'package:flutter/material.dart';
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
          return GridView.builder(
            itemCount: data?.length,
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            itemBuilder: (context, index) {
              final file = data?[index];
              return FutureBuilder(
                future: file,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data;
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: MemoryImage(data!),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
