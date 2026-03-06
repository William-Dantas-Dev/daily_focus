import 'package:flutter/material.dart';

import './widgets/splash_loading_section.dart';
import './widgets/splash_branding.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF0B0820),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              SizedBox(height: 40),
              Expanded(child: Center(child: SplashBranding())),
              SplashLoadingSection(
                progress: 0.35,
                statusText: "Preparing your workspace...",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
