import 'package:daily_focus/features/shell/shell_page.dart';
import 'package:flutter/material.dart';

import '../../features/splash/splash_page.dart';

class AppRoutes {
  static const splash = '/splash';
  static const shell = '/shell';
  static const home = '/home';
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case AppRoutes.shell:
        return MaterialPageRoute(builder: (_) => const ShellPage());
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

class UnknownRoutePage extends StatelessWidget {
  const UnknownRoutePage({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Rota não encontrada')));
}
