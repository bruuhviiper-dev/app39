import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import 'verses.dart';

/// Conteúdo das DINÂMICAS para casais (offline): perguntas para aproximar +
/// Desafio de 30 dias de amor. Carregado de `assets/couple/<lang>.json`
/// (pt/en/es; fallback EN). Chame [init] no startup, depois de [VerseData.init].
///
/// O GERADOR de mensagens reaproveita o conteúdo de [VerseData] por TOM
/// (ver [tonesByCategory]); não precisa de conteúdo próprio.
class CoupleData {
  CoupleData._();

  static final Map<String, Map<String, List<String>>> _content = {};
  static bool _loaded = false;

  static Future<void> init() async {
    if (_loaded) return;
    for (final lang in const ['pt', 'en', 'es']) {
      try {
        final raw = await rootBundle.loadString('assets/couple/$lang.json');
        final map = json.decode(raw) as Map<String, dynamic>;
        _content[lang] = map.map((k, v) =>
            MapEntry(k, (v as List).map((e) => e as String).toList()));
      } catch (_) {
        // idioma ausente: usa fallback
      }
    }
    _loaded = true;
  }

  static Map<String, List<String>> _data(String lang) =>
      _content[lang] ?? _content['en'] ?? _content['pt'] ?? const {};

  static List<String> questions(String lang) => _data(lang)['questions'] ?? const [];
  static List<String> challenges(String lang) => _data(lang)['challenges'] ?? const [];

  /// Pergunta do dia (determinística) para o cartão de dinâmica.
  static String questionOfToday(String lang) {
    final q = questions(lang);
    if (q.isEmpty) return '';
    final now = DateTime.now();
    final seed = now.year * 1000 + now.difference(DateTime(now.year, 1, 1)).inDays;
    return q[seed % q.length];
  }

  /// Desafio do dia [day] (1..30). Vazio se fora do intervalo.
  static String challenge(String lang, int day) {
    final c = challenges(lang);
    if (day < 1 || day > c.length) return '';
    return c[day - 1];
  }

  /// Tons do GERADOR → categorias de [VerseData] que alimentam cada tom.
  static const Map<String, List<String>> tonesByCategory = {
    'romantico': ['declaracao', 'te_amo', 'paixao'],
    'fofo': ['bomdia', 'boanoite'],
    'saudade': ['saudade', 'distancia'],
    'desculpas': ['reconciliacao'],
    'engracado': ['cantadas'],
    'compromisso': ['casamento', 'namoro'],
    'gratidao': ['gratidao'],
  };

  static const List<String> toneKeys = [
    'romantico', 'fofo', 'saudade', 'desculpas', 'engracado', 'compromisso',
    'gratidao',
  ];
}
