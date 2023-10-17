import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    _tabController = TabController(length: 2, vsync: this);
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
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(CupertinoIcons.bars),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                text: 'Images',
              ),
              Tab(
                text: 'Videos',
              ),
            ],
          )),
      drawer: Drawer(
        child: ListView(
          children: [],
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
