import 'package:flutter/material.dart';
import 'package:daily_focus/l10n/arb/app_localizations.dart';
import 'focus_pulse_logo.dart';
import 'rotating_splash_text.dart';

class SplashBranding extends StatelessWidget {
  const SplashBranding({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const FocusPulseLogo(),
        const SizedBox(height: 30),
        Text(
          loc.appName,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        const RotatingSplashText(),
      ],
    );
  }
}
