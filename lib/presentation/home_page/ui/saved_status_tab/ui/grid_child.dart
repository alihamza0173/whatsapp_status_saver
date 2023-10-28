import 'package:flutter/material.dart';

class GridChild extends StatelessWidget {
  const GridChild({
    super.key,
    required this.child,
    this.onTap,
  });

  final Widget child;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: child,
      ),
    );
  }
}
