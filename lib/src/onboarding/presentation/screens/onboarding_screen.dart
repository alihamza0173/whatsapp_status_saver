import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsapp_status_saver/application/common/app_images.dart';
import 'package:whatsapp_status_saver/application/extensions/context_extensions.dart';
import 'package:whatsapp_status_saver/router/app_routes.dart';
import 'package:whatsapp_status_saver/src/onboarding/presentation/providers/onboarding_provider.dart';

class OnBoardingScreen extends ConsumerWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const .all(24.0),
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            const Spacer(),
            Image.asset(AppImages.illustration, height: 150, width: 150),
            const SizedBox(height: 18.0),
            Text(context.l10n.statusSaverDescription, textAlign: .center),
            const Spacer(),
            Text(
              context.l10n.permissionPrompt,
              style: const TextStyle(fontSize: 12.0),
              textAlign: .center,
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                fixedSize: Size.fromWidth(MediaQuery.sizeOf(context).width),
              ),
              onPressed: () => ref
                  .read(onBoardingProvider.notifier)
                  .requestPermission()
                  .then((value) {
                    if (context.mounted) {
                      context.go(AppRoutes.homeScreen);
                    }
                  }),
              child: Text(context.l10n.grantPermission),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
