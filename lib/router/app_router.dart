import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsapp_status_saver/router/app_routes.dart';
import 'package:whatsapp_status_saver/src/home/presentation/screens/home_screen.dart';
import 'package:whatsapp_status_saver/src/whatsapp_status/image_status/full_screen_image_view.dart';
import 'package:whatsapp_status_saver/src/whatsapp_status/videos_status/full_screen_video_view.dart';
import 'package:whatsapp_status_saver/src/onboarding/presentation/screens/onboarding_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
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
        builder: (context, state) => const FullscreenImageView(),
      ),
      GoRoute(
        path: AppRoutes.fullScreenVideo,
        builder: (context, state) => const FullscreenVideoViewer(),
      ),
    ],
    initialLocation: AppRoutes.onBoardingScreen,
  );
});
