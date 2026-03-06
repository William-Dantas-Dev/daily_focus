import 'package:flutter/material.dart';

import 'focus_pulse_logo.dart';

class SplashBranding extends StatelessWidget {
  const SplashBranding({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FocusPulseLogo(),
        SizedBox(height: 30),
        Text(
          "Daily Focus",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 8),
        Text(
          "Focus on what truly matters.",
          style: TextStyle(fontSize: 15, color: Colors.white70),
        ),
      ],
    );
  }
}
