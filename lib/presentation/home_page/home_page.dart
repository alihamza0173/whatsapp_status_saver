import 'package:flutter/material.dart';
import 'package:whatsapp_status_saver/presentation/home_page/ui/images_tab/images_tab.dart';
import 'package:whatsapp_status_saver/presentation/home_page/ui/saved_status_tab/saved_status_tab.dart';
import 'package:whatsapp_status_saver/presentation/home_page/ui/videos_tab/videos_tab.dart';

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
    return Scaffold(
      appBar: AppBar(
          title: const Text('Status Saver'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Images'),
              Tab(text: 'Videos'),
              Tab(text: 'Saved'),
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
