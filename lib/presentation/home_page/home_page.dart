import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_status_saver/application/providers/settings_provider.dart';
import 'package:whatsapp_status_saver/l10n/l10n.dart';
import 'package:whatsapp_status_saver/presentation/common/toggle_theme_button.dart';
import 'package:whatsapp_status_saver/presentation/home_page/ui/images_tab/images_tab.dart';
import 'package:whatsapp_status_saver/presentation/home_page/ui/saved_status_tab/saved_status_tab.dart';
import 'package:whatsapp_status_saver/presentation/home_page/ui/videos_tab/videos_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
          title: Text(locale.appName),
          actions: [
            const ToggleTheme(),
            IconButton(
              onPressed: () {
                _switchLanguage(context, locale);
              },
              icon: const Icon(Icons.language),
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: locale.images),
              Tab(text: locale.videos),
              Tab(text: locale.saved),
            ],
          )),
      drawer: Drawer(
        child: ListView(
          children: const [],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ImagesTab(),
          VideosTab(),
          SavedStatusTab(),
        ],
      ),
    );
  }

  Future<dynamic> _switchLanguage(
      BuildContext context, AppLocalizations locale) {
    final provider = context.read<SettingsProvider>();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(locale.language),
          content: Column(
              mainAxisSize: MainAxisSize.min,
              children: L10n.languages.entries
                  .map(
                    (e) => RadioListTile(
                      title: Text(e.value),
                      value: e.key,
                      groupValue: provider.locale?.languageCode,
                      onChanged: (value) {
                        provider.setLocale(Locale(e.key));
                        Navigator.pop(context);
                      },
                    ),
                  )
                  .toList()),
        );
      },
    );
  }
}
