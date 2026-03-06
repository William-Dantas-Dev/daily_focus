import 'package:flutter/material.dart';

class SplashLoadingHeader extends StatelessWidget {
  const SplashLoadingHeader({
    super.key,
    required this.label,
    required this.progress,
  });

  final String label;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final percent = (progress * 100).toInt();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        Text('$percent%', style: const TextStyle(color: Colors.blue)),
      ],
    );
  }
}
