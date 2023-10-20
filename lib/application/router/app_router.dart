import 'package:go_router/go_router.dart';
import 'package:whatsapp_status_saver/application/router/app_routes.dart';
import 'package:whatsapp_status_saver/presentation/home_page/home_page.dart';
import 'package:whatsapp_status_saver/presentation/home_page/ui/full_screen_image_view.dart';
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
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: AppRoutes.onBoardingScreen,
          builder: (context, state) => const OnBoardingScreen(),
        ),
        GoRoute(
          path: AppRoutes.fullScreenImage,
          builder: (context, state) => const FullscreenImageViewer(),
        ),
      ],
      initialLocation: initialRouteResolver,
    );
  }
}
