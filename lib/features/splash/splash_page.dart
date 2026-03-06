import 'package:flutter/material.dart';
import './widgets/splash_loading_section.dart';
import './widgets/splash_branding.dart';
import 'package:daily_focus/l10n/app_localizations.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
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
                label: loc.splashStartingUp,
                statusText: loc.splashPreparingWorkspace,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
