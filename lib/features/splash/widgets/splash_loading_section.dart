import 'package:flutter/material.dart';
import 'splash_loading_header.dart';

class SplashLoadingSection extends StatelessWidget {
  const SplashLoadingSection({
    super.key,
    required this.statusText,
    this.label = "Starting up",
  });

  final String statusText;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SplashLoadingHeader(label: label),
        const SizedBox(height: 18),
        const SizedBox(
          width: 26,
          height: 26,
          child: CircularProgressIndicator(
            strokeWidth: 2.6,
            backgroundColor: Colors.white10,
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF7C5CFF)),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          statusText,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 12,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
