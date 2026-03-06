import 'package:flutter/material.dart';
import 'splash_loading_header.dart';

class SplashLoadingSection extends StatelessWidget {
  const SplashLoadingSection({
    super.key,
    required this.progress,
    required this.statusText,
    this.label = "Starting up",
  });

  final double progress;
  final String statusText;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SplashLoadingHeader(
          label: label,
          progress: progress,
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            backgroundColor: Colors.white10,
            valueColor: const AlwaysStoppedAnimation<Color>(
              Colors.blue,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Text(
            statusText,
            style: const TextStyle(
              color: Colors.white38,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}