import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_status_saver/router/app_routes.dart';
import 'package:whatsapp_status_saver/src/onboarding/presentation/providers/onboarding_provider.dart';
import 'package:whatsapp_status_saver/src/onboarding/presentation/states/onboarding_state.dart';

final goRouterNotifierProvider = ChangeNotifierProvider((ref) {
  return GoRouterNotifier(ref);
});

class GoRouterNotifier extends ChangeNotifier {
  final Ref _ref;
  String initialLocation = AppRoutes.onBoardingScreen;
  bool _isStoragePermissionAllowed = false;

  GoRouterNotifier(this._ref) {
    _ref.read(onBoardingProvider.notifier).addListener(_checkUserOnboarded);
  }

  void _checkUserOnboarded(OnBoardingState state) {
    _isStoragePermissionAllowed = state.isStoragePermissionAllowed;
    notifyListeners();
  }

  bool get isStoragePermissionAllowed => _isStoragePermissionAllowed;
}
