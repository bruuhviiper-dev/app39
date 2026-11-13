import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_text_styles.dart';
import '../data/couple_data.dart';
import '../l10n/strings.dart';
import '../services/app_state.dart';

/// Desafio de 30 dias de amor: um gesto por dia. Um dia pode ser concluído por
/// dia de calendário; progresso e streak persistem no AppState.
class ChallengeScreen extends StatelessWidget {
  const ChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = T.of(context);
    final p = Palette.of(context);
    final state = context.watch<AppState>();
    final day = state.challengeCurrentDay; // 0 = completou os 30
    final done = state.challengeCount;

    return Scaffold(
      appBar: AppBar(title: Text(t.chTitle), backgroundColor: p.bg),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(AppSpacing.screenPadding,
            AppSpacing.x3, AppSpacing.screenPadding, AppSpacing.x7),
        children: [
          // progresso
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: done / 30,
                    minHeight: 10,
                    backgroundColor: p.surface,
                    valueColor:
                        const AlwaysStoppedAnimation(AppColors.gold),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(t.chProgress.replaceFirst('{n}', '$done'),
                  style:
                      AppTextStyles.caption.copyWith(color: p.textSecondary)),
            ],
          ),
          const SizedBox(height: AppSpacing.x4),

          if (day == 0)
            _Banner(icon: LucideIcons.partyPopper, text: t.chComplete)
          else ...[
            _CurrentDayCard(day: day, state: state),
            if (state.challengeDoneToday)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child:
                    _Banner(icon: LucideIcons.heart, text: t.chComeTomorrow),
              ),
          ],

          const SizedBox(height: AppSpacing.x4),
          Text('30 ${t.chDayWord.toLowerCase()}s',
              style: AppTextStyles.overline.copyWith(color: p.textSecondary)),
          const SizedBox(height: 10),
          _DaysGrid(state: state),
        ],
      ),
    );
  }
}

class _CurrentDayCard extends StatelessWidget {
  const _CurrentDayCard({required this.day, required this.state});
  final int day;
  final AppState state;

  @override
  Widget build(BuildContext context) {
    final t = T.of(context);
    final p = Palette.of(context);
    final text = CoupleData.challenge(t.lang, day);
    final doneToday = state.challengeDoneToday;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: p.surface,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: AppColors.gold),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${t.chDayWord} $day',
              style: AppTextStyles.overline.copyWith(color: AppColors.gold)),
          const SizedBox(height: 10),
          Text(text,
              style: AppTextStyles.inspQuote.copyWith(color: p.textPrimary)),
          const SizedBox(height: 18),
          FilledButton.icon(
            onPressed:
                doneToday ? null : () => state.completeChallengeDay(day),
            icon: Icon(doneToday ? LucideIcons.check : LucideIcons.heart,
                size: 18),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.gold,
              foregroundColor: AppColors.bg,
              minimumSize: const Size.fromHeight(48),
              disabledBackgroundColor: p.border,
            ),
            label: Text(doneToday ? t.chDoneWord : t.chMarkDone),
          ),
        ],
      ),
    );
  }
}

class _DaysGrid extends StatelessWidget {
  const _DaysGrid({required this.state});
  final AppState state;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final current = state.challengeCurrentDay;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 30,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemBuilder: (_, i) {
        final day = i + 1;
        final isDone = state.isChallengeDone(day);
        final isCurrent = day == current;
        return Container(
          decoration: BoxDecoration(
            color: isDone ? AppColors.gold : p.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: isCurrent ? AppColors.gold : p.border,
                width: isCurrent ? 2 : 1),
          ),
          child: Center(
            child: isDone
                ? const Icon(LucideIcons.heart, color: AppColors.bg, size: 18)
                : Text('$day',
                    style: AppTextStyles.caption.copyWith(
                        color: isCurrent ? AppColors.gold : p.textSecondary,
                        fontWeight: FontWeight.w700)),
          ),
        );
      },
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.goldPill,
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.gold, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text,
                style: AppTextStyles.body.copyWith(color: p.textPrimary)),
          ),
        ],
      ),
    );
  }
}
