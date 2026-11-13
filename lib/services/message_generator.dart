import 'dart:math';

import '../data/couple_data.dart';
import '../data/verses.dart';

/// Gera uma mensagem de amor combinando TOM + NOME do par, reaproveitando o banco
/// de frases ([VerseData]) por categoria (ver [CoupleData.tonesByCategory]).
/// Offline, conteúdo original. Personaliza inserindo o nome quando informado.
class MessageGenerator {
  MessageGenerator._();

  static final Random _rnd = Random();

  /// Gera uma mensagem no [tone] para [lang], personalizada com [name] (opcional).
  static String generate({
    required String lang,
    required String tone,
    String name = '',
  }) {
    final cats = CoupleData.tonesByCategory[tone] ?? const ['declaracao'];
    final pool = <String>[
      for (final c in cats)
        for (final v in VerseData.byCategory(lang, c)) v.text,
    ];
    final base = pool.isEmpty
        ? VerseData.random(lang).text
        : pool[_rnd.nextInt(pool.length)];
    return personalize(base, name);
  }

  /// Insere o nome no começo da frase, de forma natural ("Maria, você é...").
  /// Não personaliza se o nome estiver vazio ou a frase começar com emoji.
  static String personalize(String text, String name) {
    final n = name.trim();
    if (n.isEmpty || text.isEmpty) return text;
    final first = text[0];
    if (first.toLowerCase() == first.toUpperCase()) {
      // começa com emoji/símbolo — não força o nome no meio
      return text;
    }
    final lowered = first.toLowerCase() + text.substring(1);
    return '$n, $lowered';
  }
}
