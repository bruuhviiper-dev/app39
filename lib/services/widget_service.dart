import 'package:home_widget/home_widget.dart';

import '../data/verses.dart';

/// Atualiza o WIDGET de tela inicial com a FRASE DO DIA (renderização NATIVA
/// via RemoteViews — nunca renderFlutterWidget com foto, que trava em loop).
class WidgetService {
  WidgetService._();

  static const _androidName = 'QuoteWidgetProvider';
  static const _daysName = 'DaysWidgetProvider';

  /// Grava a frase do dia (no idioma) + nome do app e manda atualizar o widget.
  static Future<void> updateDailyQuote({
    required String lang,
    required String appName,
  }) async {
    try {
      final verse = VerseData.ofToday(lang);
      await HomeWidget.saveWidgetData<String>('quote_text', verse.text);
      await HomeWidget.saveWidgetData<String>('app_name', appName);
      await HomeWidget.updateWidget(androidName: _androidName);
    } catch (_) {
      // sem widget na tela / plataforma não suportada: ignora
    }
  }

  /// Grava "dias juntos" + nome do par e atualiza o widget do casal.
  static Future<void> updateDaysTogether({
    required int days,
    required String label,
    required String name,
  }) async {
    try {
      await HomeWidget.saveWidgetData<String>('days_number', '$days');
      await HomeWidget.saveWidgetData<String>('days_label', label);
      await HomeWidget.saveWidgetData<String>('couple_name', name);
      await HomeWidget.updateWidget(androidName: _daysName);
    } catch (_) {
      // sem widget na tela / plataforma não suportada: ignora
    }
  }
}
