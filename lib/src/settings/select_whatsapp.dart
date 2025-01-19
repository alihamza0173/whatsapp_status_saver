import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_status_saver/application/common/app_images.dart';
import 'package:whatsapp_status_saver/core/enums/status_directory.dart';
import 'package:whatsapp_status_saver/src/settings/providers/settings_provider.dart';

class SelectWhatsapp extends ConsumerWidget {
  const SelectWhatsapp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Builder(builder: (context) {
      final state = ref.watch(settingsProvider);
      final provider = ref.read(settingsProvider.notifier);
      return Column(
        children: [
          ListTile(
            leading: Image.asset(AppImages.whatsapp, height: 30),
            title: const Text('WhatsApp'),
            trailing: state.isWhatsapp
                ? const Icon(Icons.check, color: Colors.green)
                : null,
            onTap: () => provider.setStatusDir(StatusDirectory.whatsapp),
          ),
          ListTile(
            leading: Image.asset(AppImages.whatsappBusiness, height: 30),
            title: const Text('WhatsApp Business'),
            trailing: state.isWhatsappBusiness
                ? const Icon(Icons.check, color: Colors.green)
                : null,
            onTap: () =>
                provider.setStatusDir(StatusDirectory.whatsappBusiness),
          ),
        ],
      );
    });
  }
}
