import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_text_styles.dart';
import '../l10n/strings.dart';
import '../data/verses.dart';
import '../services/app_state.dart';
import '../services/notification_service.dart';
import '../services/widget_service.dart';
import 'animated_card_screen.dart';
import 'challenge_screen.dart';
import 'generator_screen.dart';
import 'letters_screen.dart';
import 'questions_screen.dart';

/// Aba "Nós" — hub dos recursos de casal: contador de dias juntos, nome do par,
/// data de início + atalhos para o Gerador, Perguntas e Desafio de 30 dias.
class CoupleHubScreen extends StatelessWidget {
  const CoupleHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = T.of(context);
    final p = Palette.of(context);
    final state = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(title: Text(t.navCouple), backgroundColor: p.bg),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(AppSpacing.screenPadding,
            AppSpacing.x3, AppSpacing.screenPadding, AppSpacing.x7),
        children: [
          _DaysCard(state: state),
          const SizedBox(height: AppSpacing.x3),
          _SettingTile(
            icon: LucideIcons.userRound,
            label: t.coupleNameLabel,
            value: state.hasPartnerName ? state.partnerName : t.coupleTapToSet,
            onTap: () => _editName(context, state),
          ),
          _SettingTile(
            icon: LucideIcons.calendarHeart,
            label: t.coupleDateLabel,
            value: state.hasRelationship
                ? _fmt(state.relationshipStart!)
                : t.coupleTapToSet,
            onTap: () => _pickDate(context, state),
          ),
          _CareReminderTile(state: state),
          const SizedBox(height: AppSpacing.x4),
          _FeatureCard(
            icon: LucideIcons.wandSparkles,
            title: t.cardGenerator,
            desc: t.cardGeneratorDesc,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => const GeneratorScreen())),
          ),
          _FeatureCard(
            icon: LucideIcons.messagesSquare,
            title: t.cardQuestions,
            desc: t.cardQuestionsDesc,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => const QuestionsScreen())),
          ),
          _FeatureCard(
            icon: LucideIcons.calendarCheck,
            title: t.cardChallenge,
            desc: t.cardChallengeDesc,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => const ChallengeScreen())),
          ),
          _FeatureCard(
            icon: LucideIcons.mail,
            title: t.cardLetters,
            desc: t.cardLettersDesc,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => const LettersScreen())),
          ),
          _FeatureCard(
            icon: LucideIcons.clapperboard,
            title: t.cardAnimated,
            desc: t.cardAnimatedDesc,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => AnimatedCardScreen(
                    message: VerseData.ofToday(t.lang).text))),
          ),
        ],
      ),
    );
  }

  static String _fmt(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/'
      '${d.month.toString().padLeft(2, '0')}/${d.year}';

  Future<void> _editName(BuildContext context, AppState state) async {
    final t = T.of(context);
    final ctrl = TextEditingController(text: state.partnerName);
    final p = Palette.of(context);
    final name = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: p.surface,
        title: Text(t.coupleNameLabel,
            style: AppTextStyles.sectionTitle.copyWith(color: p.textPrimary)),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          style: AppTextStyles.body.copyWith(color: p.textPrimary),
          decoration: InputDecoration(hintText: t.namePromptHint),
          onSubmitted: (v) => Navigator.pop(ctx, v),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, ''),
              child: Text(t.dlgClear)),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, ctrl.text),
              child: Text(t.dlgSave)),
        ],
      ),
    );
    if (name != null) state.setPartnerName(name);
  }

  Future<void> _pickDate(BuildContext context, AppState state) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: state.relationshipStart ?? now,
      firstDate: DateTime(1980),
      lastDate: now,
    );
    if (picked != null) {
      state.setRelationshipStart(picked);
      if (context.mounted) {
        await WidgetService.updateDaysTogether(
          days: state.daysTogether,
          label: T.of(context).widgetDaysLabel,
          name: state.partnerName,
        );
      }
    }
  }
}

class _DaysCard extends StatelessWidget {
  const _DaysCard({required this.state});
  final AppState state;

  @override
  Widget build(BuildContext context) {
    final t = T.of(context);
    final p = Palette.of(context);
    if (!state.hasRelationship) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.x4),
        decoration: BoxDecoration(
          color: p.surface,
          borderRadius: BorderRadius.circular(AppRadii.card),
          border: Border.all(color: p.border),
        ),
        child: Row(
          children: [
            const Icon(LucideIcons.heart, color: AppColors.gold, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Text(t.coupleNoDate,
                  style:
                      AppTextStyles.body.copyWith(color: p.textSecondary)),
            ),
          ],
        ),
      );
    }
    final msg = _nextDateMessage(context, state.relationshipStart!);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.gold, AppColors.goldDark],
        ),
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Column(
        children: [
          const Icon(LucideIcons.heart, color: Colors.white, size: 26),
          const SizedBox(height: 8),
          Text('${state.daysTogether}',
              style: AppTextStyles.appTitle.copyWith(
                  color: Colors.white, fontSize: 56, height: 1.0)),
          Text(t.coupleDaysWord,
              style: AppTextStyles.body.copyWith(color: Colors.white)),
          if (msg != null) ...[
            const SizedBox(height: 12),
            Text(msg,
                textAlign: TextAlign.center,
                style: AppTextStyles.caption
                    .copyWith(color: Colors.white.withValues(alpha: 0.92))),
          ],
        ],
      ),
    );
  }

  /// Mensagem da próxima data: aniversário anual se estiver perto, senão o mês.
  String? _nextDateMessage(BuildContext context, DateTime start) {
    final t = T.of(context);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // próximo aniversário anual
    var anniv = DateTime(now.year, start.month, start.day);
    if (anniv.isBefore(today)) anniv = DateTime(now.year + 1, start.month, start.day);
    final daysToAnniv = anniv.difference(today).inDays;

    // próximo "mêsversário" (mesmo dia do mês)
    var mth = DateTime(now.year, now.month, start.day);
    if (mth.isBefore(today)) {
      mth = DateTime(now.year, now.month + 1, start.day);
    }
    final daysToMth = mth.difference(today).inDays;

    if (daysToAnniv == 0 || daysToMth == 0) return t.coupleTodaySpecial;
    if (daysToAnniv <= 31) {
      return t.coupleNextAnniversary.replaceFirst('{n}', '$daysToAnniv');
    }
    return t.coupleNextMonthsary.replaceFirst('{n}', '$daysToMth');
  }
}

class _SettingTile extends StatelessWidget {
  const _SettingTile(
      {required this.icon,
      required this.label,
      required this.value,
      required this.onTap});
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: p.surface,
        borderRadius: BorderRadius.circular(AppRadii.card),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadii.card),
              border: Border.all(color: p.border),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Row(
              children: [
                Icon(icon, size: 20, color: AppColors.gold),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(label,
                      style:
                          AppTextStyles.body.copyWith(color: p.textPrimary)),
                ),
                Flexible(
                  child: Text(value,
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.caption
                          .copyWith(color: p.textSecondary)),
                ),
                const SizedBox(width: 6),
                Icon(LucideIcons.chevronRight, size: 18, color: p.textSecondary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CareReminderTile extends StatelessWidget {
  const _CareReminderTile({required this.state});
  final AppState state;

  Future<void> _toggle(BuildContext context, bool on) async {
    final t = T.of(context);
    if (on) {
      final granted = await NotificationService.instance.requestPermission();
      if (!granted) return;
      await NotificationService.instance.scheduleCareReminder(
        title: t.appName,
        body: t.careNotifBody,
      );
      state.setCareReminderOn(true);
    } else {
      await NotificationService.instance.cancelCareReminder();
      state.setCareReminderOn(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = T.of(context);
    final p = Palette.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          color: p.surface,
          borderRadius: BorderRadius.circular(AppRadii.card),
          border: Border.all(color: p.border),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        child: Row(
          children: [
            const Icon(LucideIcons.bellRing, size: 20, color: AppColors.gold),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t.careReminderLabel,
                      style: AppTextStyles.body.copyWith(color: p.textPrimary)),
                  Text(t.careReminderDesc,
                      style: AppTextStyles.caption
                          .copyWith(color: p.textSecondary)),
                ],
              ),
            ),
            Switch(
              value: state.careReminderOn,
              onChanged: (v) => _toggle(context, v),
              activeThumbColor: AppColors.bg,
              activeTrackColor: AppColors.gold,
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard(
      {required this.icon,
      required this.title,
      required this.desc,
      required this.onTap});
  final IconData icon;
  final String title;
  final String desc;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: p.surface,
        borderRadius: BorderRadius.circular(AppRadii.card),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadii.card),
              border: Border.all(color: p.border),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppColors.goldPill,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: AppColors.gold, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: AppTextStyles.sectionTitle
                              .copyWith(color: p.textPrimary)),
                      const SizedBox(height: 2),
                      Text(desc,
                          style: AppTextStyles.caption
                              .copyWith(color: p.textSecondary)),
                    ],
                  ),
                ),
                Icon(LucideIcons.chevronRight, size: 20, color: p.textSecondary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
