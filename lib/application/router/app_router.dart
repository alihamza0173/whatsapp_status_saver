import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsapp_status_saver/presentation/home_page/home_page.dart';

final appRouterSinglton = AppRouter();

class AppRouter {
  late final GoRouter router;

  String get initialRouteResolver => '/';

  AppRouter() {
    router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          // builder: (context, state) => const HomePage(),
          pageBuilder: (context, state) => const MaterialPage(
            child: HomePage(),
          ),
        ),
      ],
      initialLocation: initialRouteResolver,
    );
  }
}
