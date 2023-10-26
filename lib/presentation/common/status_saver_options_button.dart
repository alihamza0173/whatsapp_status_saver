import 'package:flutter/material.dart';

class StatusSaverOptionsButton extends StatelessWidget {
  const StatusSaverOptionsButton({
    super.key,
    this.onSavePressed,
    this.onSharePressed,
  });
  final void Function()? onSavePressed;
  final void Function()? onSharePressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 180,
      right: 16,
      child: Column(
        children: [
          OptionsButton(
            onPressed: onSavePressed,
            icon: const Icon(Icons.download_sharp),
          ),
          const SizedBox(height: 16),
          OptionsButton(
            onPressed: onSharePressed,
            icon: const Icon(Icons.share),
          )
        ],
      ),
    );
  }
}

class OptionsButton extends StatelessWidget {
  const OptionsButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });
  final void Function()? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.white,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.green),
      ),
      onPressed: onPressed,
      icon: icon,
    );
  }
}
