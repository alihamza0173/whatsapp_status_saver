import 'package:flutter/material.dart';
import 'package:whatsapp_status_saver/application/common/app_images.dart';
import 'package:whatsapp_status_saver/application/providers/file_manager_provider.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

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
                onPressed: () {
                  FileManagerProvider().checkPermission();
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
