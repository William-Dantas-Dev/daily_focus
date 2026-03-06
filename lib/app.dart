import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import './core/localization/locale_provider.dart';
import './core/localization/app_localization_config.dart';
import './core/router/app_router.dart';

class DailyFocusApp extends ConsumerWidget {
  const DailyFocusApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    return MaterialApp(
      title: 'Daily Focus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      locale: locale,
      supportedLocales: AppLocalizationConfig.supportedLocales,
      localizationsDelegates: AppLocalizationConfig.localizationsDelegates,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
