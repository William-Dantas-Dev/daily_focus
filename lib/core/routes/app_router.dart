import 'package:flutter/material.dart';

import '../../features/home/home_page.dart';
import '../../features/favorites/favorites_page.dart';
import 'app_routes.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
          settings: settings,
        );

      case AppRoutes.favorites:
        return MaterialPageRoute(
          builder: (_) => const FavoritesPage(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const _NotFoundPage(),
          settings: settings,
        );
    }
  }
}

class _NotFoundPage extends StatelessWidget {
  const _NotFoundPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rota não encontrada')),
      body: const Center(
        child: Text('Essa rota não existe.'),
      ),
    );
  }
}