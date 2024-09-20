// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsapp_status_saver/application/common/app_images.dart';
import 'package:whatsapp_status_saver/application/extensions/context_extentions.dart';
import 'package:whatsapp_status_saver/router/app_routes.dart';
import 'package:whatsapp_status_saver/src/onboarding/presentation/providers/onboarding_provider.dart';

class OnBoardingScreen extends ConsumerWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const Spacer(),
              Image.asset(AppImages.illustation, height: 150, width: 150),
              const SizedBox(height: 18.0),
              Text(context.l10n.statusSaverDescription),
              const Spacer(),
              Text(
                context.l10n.permissionPrompt,
                style: const TextStyle(fontSize: 8.0),
              ),
              const SizedBox(height: 8.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  fixedSize: Size.fromWidth(MediaQuery.sizeOf(context).width),
                ),
                onPressed: () async {
                  await ref
                      .read(onBoardingProvider.notifier)
                      .requestPermission();

                  context.go(AppRoutes.homeScreen);
                },
                child: Text(context.l10n.grantPermission),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
