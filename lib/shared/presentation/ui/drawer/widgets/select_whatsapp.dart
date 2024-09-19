import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_status_saver/application/common/app_images.dart';
import 'package:whatsapp_status_saver/application/providers/settings_provider.dart';
import 'package:whatsapp_status_saver/core/enums/whatsapp.dart';

class SelectWhatsapp extends StatelessWidget {
  const SelectWhatsapp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final provider = context.watch<SettingsProvider>();
      return Column(
        children: [
          ListTile(
            leading: Image.asset(AppImages.whatsapp, height: 30),
            title: const Text('WhatsApp'),
            trailing: provider.isWhatsapp
                ? const Icon(Icons.check, color: Colors.green)
                : null,
            onTap: () => provider.setStatusDir(WhtasappStatusDir.whatsapp),
          ),
          ListTile(
            leading: Image.asset(AppImages.whatsappBuisness, height: 30),
            title: const Text('WhatsApp Buisness'),
            trailing: !provider.isWhatsapp
                ? const Icon(Icons.check, color: Colors.green)
                : null,
            onTap: () =>
                provider.setStatusDir(WhtasappStatusDir.whatsappBusiness),
          ),
        ],
      );
    });
  }
}
