import 'package:flutter/material.dart';

class NoMediaAvailable extends StatelessWidget {
  const NoMediaAvailable({
    super.key,
    required this.type,
    required this.icon,
  });
  final String type;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.green,
        ),
        const SizedBox(height: 8.0),
        Text(
          'No $type Available Now',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.green),
        ),
        const SizedBox(height: 8.0),
        const Text(
            '* Open WhatsApp \n* View Statuses \n* Open this App to Download'),
      ],
    );
  }
}
