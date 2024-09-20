import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:whatsapp_status_saver/application/common/directories.dart';
import 'package:whatsapp_status_saver/src/home/presentation/providers/usecase_providers.dart';

class StatusSaverOptionsButton extends ConsumerWidget {
  const StatusSaverOptionsButton({
    super.key,
    required this.file,
    required this.isSaved,
  });
  final File file;
  final bool isSaved;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      bottom: 180,
      right: 16,
      child: Column(
        children: [
          if (!isSaved)
            OptionsButton(
              onPressed: () async {
                final result = await ref
                    .read(saveSavedStatusUseCaseProvider)
                    .execute(savedStatusDir, file);
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(result)),
                );
              },
              icon: const Icon(Icons.download_sharp),
            ),
          const SizedBox(height: 16),
          OptionsButton(
            onPressed: () {
              Share.shareXFiles(
                [XFile(file.path)],
                text: 'Shared from WhatsApp Status Saver',
              );
            },
            icon: const Icon(Icons.share),
          )
        ],
      ),
    );
  }
}

class OptionsButton extends StatelessWidget {
  const OptionsButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });
  final void Function()? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.white,
      style: IconButton.styleFrom(
        backgroundColor: Colors.green,
      ),
      onPressed: onPressed,
      icon: icon,
    );
  }
}
