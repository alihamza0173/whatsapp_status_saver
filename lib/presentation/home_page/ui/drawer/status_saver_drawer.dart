import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:whatsapp_status_saver/application/common/app_images.dart';
import 'package:whatsapp_status_saver/application/extenstions/context_extentions.dart';
import 'package:whatsapp_status_saver/presentation/home_page/ui/drawer/select_whatsapp.dart';
import 'package:whatsapp_status_saver/presentation/home_page/ui/drawer/ui/how_to_use.dart';
import 'package:whatsapp_status_saver/presentation/home_page/ui/settings/language_settings.dart';
import 'package:whatsapp_status_saver/presentation/home_page/ui/settings/toggle_theme_switch.dart';

class StatusSaverDrawer extends StatelessWidget {
  const StatusSaverDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Colors.green,
          ),
          child: Image.asset(
            AppImages.logo,
          ),
        ),
        // Select Whatsapp Dir Tile
        const SelectWhatsapp(),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.dark_mode),
          title: Text(context.l10n.darkTheme),
          trailing: const ToggleThemeSwitch(),
        ),
        ListTile(
          leading: const Icon(Icons.language),
          title: Text(context.l10n.language),
          onTap: () => switchLanguage(context),
        ),
        ListTile(
          leading: const Icon(Icons.info, color: Colors.amber),
          title: Text(context.l10n.howToUse),
          onTap: () => howToUse(context),
        ),
        ListTile(
          leading: const Icon(Icons.share, color: Colors.blue),
          title: Text(context.l10n.share),
          onTap: () {
            Share.share(
              'You can download all Whatsapp status for free aad fast. Download it here: https://play.google.com/store/apps/details?id=com.devzeal.status_saver',
              subject: 'Status Saver',
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.star, color: Colors.green),
          title: Text(context.l10n.rateUs),
        ),
        ListTile(
          leading: const Icon(Icons.privacy_tip, color: Colors.red),
          title: Text(context.l10n.privacyPolicy),
        ),
      ],
    );
  }

  void howToUse(BuildContext context) {
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (context) {
        return const HowToUseDialog();
      },
    );
  }
}
