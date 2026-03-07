// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Daily Focus';

  @override
  String get commonSave => 'Save';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonContinue => 'Continue';

  @override
  String get splashTagline => 'Focus on what truly matters.';

  @override
  String get splashStartingUp => 'Starting up';

  @override
  String get splashPreparingWorkspace => 'Preparing your workspace...';

  @override
  String get splashAlmostReady => 'Almost ready...';

  @override
  String get homeTitle => 'Home';

  @override
  String homeGreeting(Object name) {
    return 'Hello, $name';
  }

  @override
  String get tasksTitle => 'Tasks';

  @override
  String get tasksEmptyTitle => 'No tasks found';

  @override
  String get tasksEmptySubtitle => 'Create your first task to get started';
}
