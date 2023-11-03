import 'package:flutter/material.dart';
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
          actions: const [ToggleTheme()],
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
}
