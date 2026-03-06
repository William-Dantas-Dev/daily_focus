import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';

class DailyFocusApp extends ConsumerWidget {
  const DailyFocusApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Daily Focus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
