import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsapp_status_saver/application/common/app_images.dart';
import 'package:whatsapp_status_saver/application/providers/file_manager_provider.dart';
import 'package:whatsapp_status_saver/application/router/app_routes.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final isAllowed = await FileManagerProvider().checkPermission();
      if (isAllowed) {
        // ignore: use_build_context_synchronously
        context.go(AppRoutes.homeScreen);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(225, 251, 214, 1),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const Spacer(),
              Image.asset(AppImages.illustation, height: 150, width: 150),
              const SizedBox(height: 18.0),
              const Text('A Simple Way to Save Your Statuses'),
              const Spacer(),
              const Text(
                'In Order to Save Statuses, You Need to Grant Permission',
                style: TextStyle(fontSize: 8.0),
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
                      await FileManagerProvider().checkPermission();
                  if (isAllowed) {
                    // ignore: use_build_context_synchronously
                    context.go(AppRoutes.homeScreen);
                  }
                },
                child: const Text('Grant Permission'),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
