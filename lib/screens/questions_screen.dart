import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_text_styles.dart';
import '../data/couple_data.dart';
import '../l10n/strings.dart';

/// Perguntas para casais — um baralho de perguntas para aproximar. Mostra uma
/// pergunta por vez; "Próxima" sorteia outra.
class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final _rnd = Random();
  int _i = 0;
  bool _started = false;

  void _next(int total) {
    if (total <= 1) return;
    setState(() {
      _started = true;
      var n = _i;
      while (n == _i) {
        n = _rnd.nextInt(total);
      }
      _i = n;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = T.of(context);
    final p = Palette.of(context);
    final questions = CoupleData.questions(t.lang);
    final question = questions.isEmpty
        ? ''
        : (_started ? questions[_i] : CoupleData.questionOfToday(t.lang));

    return Scaffold(
      appBar: AppBar(title: Text(t.qTitle), backgroundColor: p.bg),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(AppSpacing.screenPadding,
            AppSpacing.x3, AppSpacing.screenPadding, AppSpacing.x5),
        child: Column(
          children: [
            Text(t.qIntro,
                textAlign: TextAlign.center,
                style: AppTextStyles.caption.copyWith(color: p.textSecondary)),
            const SizedBox(height: AppSpacing.x3),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(26),
                decoration: BoxDecoration(
                  color: p.surface,
                  borderRadius: BorderRadius.circular(AppRadii.card),
                  border: Border.all(color: p.border),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(LucideIcons.messageCircleHeart,
                          color: AppColors.gold, size: 34),
                      const SizedBox(height: 20),
                      Text(question,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.inspQuote
                              .copyWith(color: p.textPrimary)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.x3),
            FilledButton.icon(
              onPressed: () => _next(questions.length),
              icon: const Icon(LucideIcons.shuffle, size: 18),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: AppColors.bg,
                minimumSize: const Size.fromHeight(50),
              ),
              label: Text(t.qNext),
            ),
          ],
        ),
      ),
    );
  }
}
