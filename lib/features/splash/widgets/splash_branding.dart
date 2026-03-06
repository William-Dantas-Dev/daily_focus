import 'package:flutter/material.dart';

import 'package:daily_focus/l10n/app_localizations.dart';
import 'focus_pulse_logo.dart';

class SplashBranding extends StatelessWidget {
  const SplashBranding({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FocusPulseLogo(),
        SizedBox(height: 30),
        Text(
          loc.appName,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 8),
        Text(
          loc.splashTagline,
          style: TextStyle(fontSize: 15, color: Colors.white70),
        ),
      ],
    );
  }
}
