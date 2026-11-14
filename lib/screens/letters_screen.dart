import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_text_styles.dart';
import '../data/love_letter.dart';
import '../l10n/strings.dart';
import '../services/app_state.dart';

/// Cartinhas programadas: mensagens que ficam LACRADAS até a data escolhida.
class LettersScreen extends StatelessWidget {
  const LettersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = T.of(context);
    final p = Palette.of(context);
    final state = context.watch<AppState>();
    final letters = state.letters;

    return Scaffold(
      appBar: AppBar(title: Text(t.lettersTitle), backgroundColor: p.bg),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const _ComposeLetterScreen())),
        backgroundColor: AppColors.gold,
        foregroundColor: AppColors.bg,
        icon: const Icon(LucideIcons.plus),
        label: Text(t.lettersNew),
      ),
      body: letters.isEmpty
          ? _Empty(text: t.lettersEmpty)
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(AppSpacing.screenPadding,
                  AppSpacing.x3, AppSpacing.screenPadding, 90),
              itemCount: letters.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (_, i) =>
                  _LetterCard(letter: letters[i], state: state),
            ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(LucideIcons.mail, size: 46, color: AppColors.gold),
            const SizedBox(height: 16),
            Text(text,
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(color: p.textSecondary)),
          ],
        ),
      ),
    );
  }
}

class _LetterCard extends StatelessWidget {
  const _LetterCard({required this.letter, required this.state});
  final LoveLetter letter;
  final AppState state;

  @override
  Widget build(BuildContext context) {
    final t = T.of(context);
    final p = Palette.of(context);
    final revealed = letter.isRevealed;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: p.surface,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: revealed ? AppColors.gold : p.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(revealed ? LucideIcons.mailOpen : LucideIcons.lock,
                  size: 18, color: AppColors.gold),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  revealed
                      ? _fmt(letter.revealAt)
                      : (letter.daysUntil == 0
                          ? t.letterOpensToday
                          : t.letterLockedIn
                              .replaceFirst('{n}', '${letter.daysUntil}')),
                  style: AppTextStyles.caption.copyWith(
                      color: revealed ? AppColors.gold : p.textSecondary,
                      fontWeight: FontWeight.w700),
                ),
              ),
              InkWell(
                onTap: () => state.removeLetter(letter.id),
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Icon(LucideIcons.trash2,
                      size: 17, color: p.textSecondary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (revealed) ...[
            Text(letter.text,
                style: AppTextStyles.inspQuote.copyWith(color: p.textPrimary)),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton.icon(
                onPressed: () =>
                    SharePlus.instance.share(ShareParams(text: letter.text)),
                icon: const Icon(LucideIcons.share2, size: 16),
                label: Text(t.share),
              ),
            ),
          ] else
            Text(t.letterSealed,
                style: AppTextStyles.body.copyWith(
                    color: p.textSecondary, fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }

  static String _fmt(DateTime d) => '${d.day.toString().padLeft(2, '0')}/'
      '${d.month.toString().padLeft(2, '0')}/${d.year}';
}

/// Tela de composição de uma nova cartinha (texto + data de abertura).
class _ComposeLetterScreen extends StatefulWidget {
  const _ComposeLetterScreen();

  @override
  State<_ComposeLetterScreen> createState() => _ComposeLetterScreenState();
}

class _ComposeLetterScreenState extends State<_ComposeLetterScreen> {
  final _ctrl = TextEditingController();
  DateTime? _reveal;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 1)),
      firstDate: now.add(const Duration(days: 1)),
      lastDate: DateTime(now.year + 20),
    );
    if (picked != null) setState(() => _reveal = picked);
  }

  void _save() {
    final t = T.of(context);
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;
    if (_reveal == null || !_reveal!.isAfter(DateTime.now())) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(t.letterNeedFuture)));
      return;
    }
    context.read<AppState>().addLetter(text, _reveal!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final t = T.of(context);
    final p = Palette.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.lettersNew), backgroundColor: p.bg),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.screenPadding),
        children: [
          TextField(
            controller: _ctrl,
            maxLines: 7,
            textCapitalization: TextCapitalization.sentences,
            style: AppTextStyles.body.copyWith(color: p.textPrimary),
            decoration: InputDecoration(
              hintText: t.letterWriteHint,
              filled: true,
              fillColor: p.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadii.card),
                borderSide: BorderSide(color: p.border),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Material(
            color: p.surface,
            borderRadius: BorderRadius.circular(AppRadii.card),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: _pickDate,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadii.card),
                  border: Border.all(color: p.border),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                child: Row(
                  children: [
                    const Icon(LucideIcons.calendarHeart,
                        size: 20, color: AppColors.gold),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(t.letterRevealLabel,
                          style: AppTextStyles.body
                              .copyWith(color: p.textPrimary)),
                    ),
                    Text(
                      _reveal == null
                          ? t.coupleTapToSet
                          : _LetterCard._fmt(_reveal!),
                      style: AppTextStyles.caption
                          .copyWith(color: p.textSecondary),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: _save,
            icon: const Icon(LucideIcons.lock, size: 18),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.gold,
              foregroundColor: AppColors.bg,
              minimumSize: const Size.fromHeight(50),
            ),
            label: Text(t.letterSave),
          ),
        ],
      ),
    );
  }
}
