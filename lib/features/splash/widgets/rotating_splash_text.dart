import 'dart:async';
import 'package:flutter/material.dart';
import 'package:daily_focus/l10n/arb/app_localizations.dart';

class RotatingSplashText extends StatefulWidget {
  const RotatingSplashText({super.key});

  @override
  State<RotatingSplashText> createState() => _RotatingSplashTextState();
}

class _RotatingSplashTextState extends State<RotatingSplashText> {
  Timer? _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;

      setState(() {
        _index++;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    final messages = [
      loc.splashTagline,
      loc.splashStartingUp,
      loc.splashPreparingWorkspace,
      loc.splashAlmostReady,
    ];

    final message = messages[_index % messages.length];

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.45),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: Text(
        message,
        key: ValueKey(message),
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.white70,
        ),
      ),
    );
  }
}