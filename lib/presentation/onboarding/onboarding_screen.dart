// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsapp_status_saver/application/common/app_images.dart';
import 'package:whatsapp_status_saver/application/providers/file_manager_provider.dart';
import 'package:whatsapp_status_saver/application/router/app_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final isAllowed = await fileManagerProvider.checkPermission();
      if (isAllowed) {
        context.go(AppRoutes.homeScreen);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
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
              Text(locale.statusSaverDescription),
              const Spacer(),
              Text(
                locale.permissionPrompt,
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
                  final isAllowed =
                      await fileManagerProvider.askForPermission();
                  if (isAllowed) {
                    context.go(AppRoutes.homeScreen);
                  }
                },
                child: Text(locale.grantPermission),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
