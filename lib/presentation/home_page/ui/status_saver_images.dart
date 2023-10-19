import 'package:flutter/material.dart';
import 'package:whatsapp_status_saver/application/providers/file_manager_provider.dart';

class StatusSaverImages extends StatelessWidget {
  const StatusSaverImages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final image = FileManagerProvider().file;
    final video = FileManagerProvider().file2;
    return Center(
        child: Column(
      children: [
        Image.file(image),
        FutureBuilder(
          future: video,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Image.memory(snapshot.data!);
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ],
    ));
  }
}
