import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_text_styles.dart';
import '../data/couple_data.dart';
import '../l10n/strings.dart';
import '../services/app_state.dart';
import '../services/message_generator.dart';
import '../services/rate_prompt.dart';

/// Gerador de mensagem: escolhe um TOM e cria uma mensagem (personalizada com o
/// nome do par, se definido). Reaproveita o banco de frases via MessageGenerator.
class GeneratorScreen extends StatefulWidget {
  const GeneratorScreen({super.key});

  @override
  State<GeneratorScreen> createState() => _GeneratorScreenState();
}

class _GeneratorScreenState extends State<GeneratorScreen> {
  String _tone = CoupleData.toneKeys.first;
  String? _message;

  void _generate(String lang, String name) {
    setState(() {
      _message = MessageGenerator.generate(lang: lang, tone: _tone, name: name);
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = T.of(context);
    final p = Palette.of(context);
    final state = context.watch<AppState>();
    final name = state.partnerName;

    return Scaffold(
      appBar: AppBar(title: Text(t.genTitle), backgroundColor: p.bg),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(AppSpacing.screenPadding,
            AppSpacing.x3, AppSpacing.screenPadding, AppSpacing.x7),
        children: [
          Text(t.genChooseTone,
              style: AppTextStyles.overline.copyWith(color: p.textSecondary)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final k in CoupleData.toneKeys)
                _ToneChip(
                  label: t.toneName(k),
                  selected: k == _tone,
                  onTap: () => setState(() => _tone = k),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.x3),
          if (state.hasPartnerName)
            Row(
              children: [
                const Icon(LucideIcons.sparkles,
                    size: 15, color: AppColors.gold),
                const SizedBox(width: 6),
                Text(t.genPersonalized.replaceFirst('{name}', name),
                    style:
                        AppTextStyles.caption.copyWith(color: AppColors.gold)),
              ],
            )
          else
            Text(t.genSetNameHint,
                style: AppTextStyles.caption.copyWith(color: p.textSecondary)),
          const SizedBox(height: AppSpacing.x3),
          _ResultCard(message: _message, emptyHint: t.genEmpty),
          const SizedBox(height: AppSpacing.x3),
          FilledButton.icon(
            onPressed: () => _generate(t.lang, name),
            icon: const Icon(LucideIcons.wandSparkles, size: 18),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.gold,
              foregroundColor: AppColors.bg,
              minimumSize: const Size.fromHeight(50),
            ),
            label: Text(_message == null ? t.genGenerate : t.genRegenerate),
          ),
          if (_message != null) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: _message!));
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(t.copied)));
                    },
                    icon: const Icon(LucideIcons.copy, size: 18),
                    label: Text(t.copy),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      SharePlus.instance
                          .share(ShareParams(text: _message!));
                      RatePrompt.registerPositiveAction();
                    },
                    icon: const Icon(LucideIcons.share2, size: 18),
                    label: Text(t.share),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _ToneChip extends StatelessWidget {
  const _ToneChip(
      {required this.label, required this.selected, required this.onTap});
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? AppColors.gold : p.surface,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: selected ? AppColors.gold : p.border),
        ),
        child: Text(label,
            style: AppTextStyles.caption.copyWith(
                color: selected ? AppColors.bg : p.textPrimary,
                fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.message, required this.emptyHint});
  final String? message;
  final String emptyHint;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 150),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: p.surface,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: p.border),
      ),
      child: Center(
        child: message == null
            ? Text(emptyHint,
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(color: p.textSecondary))
            : Text(message!,
                textAlign: TextAlign.center,
                style: AppTextStyles.inspQuote.copyWith(color: p.textPrimary)),
      ),
    );
  }
}
