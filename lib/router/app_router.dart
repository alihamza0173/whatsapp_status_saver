import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsapp_status_saver/router/app_router_notifier.dart';
import 'package:whatsapp_status_saver/router/app_routes.dart';
import 'package:whatsapp_status_saver/src/home/presentation/screens/home_screen.dart';
import 'package:whatsapp_status_saver/src/status_preview/image_status_preview/full_screen_image_view.dart';
import 'package:whatsapp_status_saver/src/status_preview/videos_status_preview/full_screen_video_view.dart';
import 'package:whatsapp_status_saver/src/onboarding/presentation/screens/onboarding_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: goRouterNotifier.initialLocation,
    refreshListenable: goRouterNotifier,
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
    redirect: (context, state) {
      final bool isStoragePermissionAllowed =
          goRouterNotifier.isStoragePermissionAllowed;
      final isGoingTo = state.uri.toString();

      // If permissions are not allowed, redirect to the onboarding screen
      if (!isStoragePermissionAllowed &&
          isGoingTo != AppRoutes.onBoardingScreen) {
        return AppRoutes.onBoardingScreen;
      }

      // If permissions are allowed and user is on onboarding screen, go to home screen
      if (isStoragePermissionAllowed &&
          isGoingTo == AppRoutes.onBoardingScreen) {
        return AppRoutes.homeScreen;
      }

      return null;
    },
  );
});
