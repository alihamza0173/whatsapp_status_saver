import 'package:flutter/material.dart';
import 'package:whatsapp_status_saver/application/common/app_images.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:whatsapp_status_saver/presentation/home_page/ui/settings/language_settings.dart';
import 'package:whatsapp_status_saver/presentation/home_page/ui/settings/toggle_theme_switch.dart';

class StatusSaverDrawer extends StatelessWidget {
  const StatusSaverDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
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
        const ListTile(
          leading: Icon(Icons.message),
          title: Text('data'),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.dark_mode),
          title: Text(locale.darkTheme),
          trailing: const ToggleThemeSwitch(),
        ),
        ListTile(
          leading: const Icon(Icons.language),
          title: Text(locale.language),
          onTap: () => switchLanguage(context),
        ),
        ListTile(
          leading: const Icon(Icons.info, color: Colors.amber),
          title: Text(locale.howToUse),
        ),
        ListTile(
          leading: const Icon(Icons.share, color: Colors.blue),
          title: Text(locale.share),
        ),
        ListTile(
          leading: const Icon(Icons.star, color: Colors.green),
          title: Text(locale.rateUs),
        ),
        ListTile(
          leading: const Icon(Icons.privacy_tip, color: Colors.red),
          title: Text(locale.privacyPolicy),
        ),
      ],
    );
  }
}