/// Uma "cartinha programada": mensagem de amor que fica LACRADA até [revealAt].
class LoveLetter {
  const LoveLetter({
    required this.id,
    required this.text,
    required this.revealAt,
    required this.createdAt,
  });

  final String id;
  final String text;
  final DateTime revealAt;
  final DateTime createdAt;

  /// Já pode ser aberta? (data de revelação já chegou).
  bool get isRevealed => !revealAt.isAfter(DateTime.now());

  /// Dias que faltam para abrir (0 se já revelada).
  int get daysUntil {
    if (isRevealed) return 0;
    final now = DateTime.now();
    final a = DateTime(now.year, now.month, now.day);
    final b = DateTime(revealAt.year, revealAt.month, revealAt.day);
    return b.difference(a).inDays;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'reveal': revealAt.millisecondsSinceEpoch,
        'created': createdAt.millisecondsSinceEpoch,
      };

  factory LoveLetter.fromJson(Map<String, dynamic> j) => LoveLetter(
        id: j['id'] as String,
        text: j['text'] as String,
        revealAt: DateTime.fromMillisecondsSinceEpoch(j['reveal'] as int),
        createdAt: DateTime.fromMillisecondsSinceEpoch(j['created'] as int),
      );
}
