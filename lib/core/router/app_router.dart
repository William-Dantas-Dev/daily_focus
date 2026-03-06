import 'package:flutter/material.dart';

import '../../features/splash/splash_page.dart';

class AppRoutes {
  static const home = '/';
  static const onboarding = '/onboarding';
  static const splash = '/splash';
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      default:
        return MaterialPageRoute(builder: (_) => const UnknownRoutePage());
    }
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Home')));
}

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Onboarding')));
}

class UnknownRoutePage extends StatelessWidget {
  const UnknownRoutePage({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Rota não encontrada')));
}
