import 'package:flutter/material.dart';

import '../home/home_page.dart';
import '../favorites/favorites_page.dart';
import 'widgets/bottom_navigation.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  void _goTo(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const HomePage(),
      FavoritesPage(
        //onGoHome: () => _goTo(0),
      ),
      const _PlaceholderPage(
        title: 'Explorar',
        subtitle: 'Explorar Em breve',
        icon: Icons.explore,
      ),
      const _PlaceholderPage(
        title: 'Configurações',
        subtitle: 'Configurações Em breve',
        icon: Icons.settings,
      ),
    ];

    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: _currentIndex, children: pages),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: _goTo,
      ),
    );
  }
}

class _PlaceholderPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _PlaceholderPage({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF070A1A), Color(0xFF05071A), Color(0xFF040515)],
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 44, color: Colors.white70),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              Text(subtitle, style: const TextStyle(color: Colors.white60)),
            ],
          ),
        ),
      ),
    );
  }
}
