import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsapp_status_saver/application/router/app_routes.dart';
import 'package:whatsapp_status_saver/presentation/home_page/home_page.dart';
import 'package:whatsapp_status_saver/presentation/onboarding/onboarding_screen.dart';

final appRouterSinglton = AppRouter();

class AppRouter {
  late final GoRouter router;

  String get initialRouteResolver => AppRoutes.onBoardingScreen;

  AppRouter() {
    router = GoRouter(
      routes: [
        GoRoute(
          path: AppRoutes.homeScreen,
          // builder: (context, state) => const HomePage(),
          pageBuilder: (context, state) => const MaterialPage(
            child: HomePage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.onBoardingScreen,
          // builder: (context, state) => const HomePage(),
          pageBuilder: (context, state) => const MaterialPage(
            child: OnBoardingScreen(),
          ),
        ),
      ],
      initialLocation: initialRouteResolver,
    );
  }
}
