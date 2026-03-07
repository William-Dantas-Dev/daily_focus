// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appName => 'Daily Focus';

  @override
  String get commonSave => 'Salvar';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonContinue => 'Continuar';

  @override
  String get splashTagline => 'Foque no que realmente importa.';

  @override
  String get splashStartingUp => 'Iniciando';

  @override
  String get splashPreparingWorkspace => 'Preparando seu ambiente...';

  @override
  String get splashAlmostReady => 'Quase pronto...';

  @override
  String get homeTitle => 'Início';

  @override
  String homeGreeting(Object name) {
    return 'Olá, $name';
  }

  @override
  String get tasksTitle => 'Tarefas';

  @override
  String get tasksEmptyTitle => 'Nenhuma tarefa encontrada';

  @override
  String get tasksEmptySubtitle => 'Crie uma tarefa para começar';
}
