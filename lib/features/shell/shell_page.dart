import 'package:flutter/material.dart';

import './widgets/bottom_navigation.dart';

class ShellPage extends StatefulWidget {
  const ShellPage({super.key});

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  int _currentIndex = 0;

  void _goTo(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const Center(child: Text("Home Page")),
      const Center(child: Text("Favorites Page")),
      const Center(child: Text("Settings Page")),
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
