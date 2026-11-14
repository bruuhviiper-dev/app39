import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gal/gal.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image/image.dart' as img;
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:share_plus/share_plus.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../l10n/strings.dart';
import '../services/gif_export.dart';
import '../services/rate_prompt.dart';

/// Cartão ANIMADO para stories: a mensagem sobre um fundo romântico com corações
/// subindo. Exporta um GIF em loop (lib `image`, Dart puro) para salvar/compartilhar.
class AnimatedCardScreen extends StatefulWidget {
  const AnimatedCardScreen({
    super.key,
    required this.message,
    this.background = 'assets/landscapes/editor_bg04.jpg',
  });

  final String message;
  final String background;

  @override
  State<AnimatedCardScreen> createState() => _AnimatedCardScreenState();
}

class _AnimatedCardScreenState extends State<AnimatedCardScreen>
    with SingleTickerProviderStateMixin {
  final _cardKey = GlobalKey();
  late final AnimationController _controller;
  double _phase = 0;
  bool _exporting = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..addListener(() {
        if (!_exporting) setState(() => _phase = _controller.value);
      });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _export() async {
    final t = T.of(context);
    setState(() => _exporting = true);
    _controller.stop();
    try {
      final boundary =
          _cardKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final pr = 480 / boundary.size.width; // GIF ~480px de largura
      const n = 18;
      final frames = <img.Image>[];
      for (var i = 0; i < n; i++) {
        setState(() => _phase = i / n);
        await WidgetsBinding.instance.endOfFrame;
        await Future<void>.delayed(const Duration(milliseconds: 16));
        final ui.Image image = await boundary.toImage(pixelRatio: pr);
        frames.add(await GifExport.fromUiImage(image));
        image.dispose();
      }
      final path = await GifExport.buildGifFile(frames, frameMs: 90);
      try {
        await Gal.putImage(path);
      } catch (_) {/* sem permissão de galeria: segue só com o compartilhar */}
      await SharePlus.instance.share(
          ShareParams(files: [XFile(path)], text: t.appName));
      RatePrompt.registerPositiveAction();
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(t.animDone)));
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(t.saveError)));
      }
    } finally {
      if (mounted) setState(() => _exporting = false);
      _controller.repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = T.of(context);
    final p = Palette.of(context);
    return Scaffold(
      backgroundColor: p.bg,
      appBar: AppBar(title: Text(t.cardAnimated), backgroundColor: p.bg),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.screenPadding),
                child: AspectRatio(
                  aspectRatio: 4 / 5,
                  child: RepaintBoundary(
                    key: _cardKey,
                    child: _Card(
                      message: widget.message,
                      background: widget.background,
                      phase: _phase,
                      brand: t.appName,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.screenPadding, 0,
                AppSpacing.screenPadding, AppSpacing.x5),
            child: FilledButton.icon(
              onPressed: _exporting ? null : _export,
              icon: _exporting
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: AppColors.bg))
                  : const Icon(LucideIcons.download, size: 18),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: AppColors.bg,
                minimumSize: const Size.fromHeight(52),
              ),
              label: Text(_exporting ? t.animExporting : t.animExport),
            ),
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    required this.message,
    required this.background,
    required this.phase,
    required this.brand,
  });

  final String message;
  final String background;
  final double phase;
  final String brand;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadii.card),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(background, fit: BoxFit.cover,
              errorBuilder: (_, _, _) =>
                  const ColoredBox(color: AppColors.bg)),
          // scrim para legibilidade
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0x330A0A12), Color(0x99140A1A), Color(0xCC140A1A)],
              ),
            ),
          ),
          // corações subindo
          CustomPaint(painter: _HeartsPainter(phase), size: Size.infinite),
          // texto
          Padding(
            padding: const EdgeInsets.all(26),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Icon(LucideIcons.heart,
                    color: AppColors.gold.withValues(alpha: 0.95), size: 30),
                const SizedBox(height: 16),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.playfairDisplay(
                    color: Colors.white,
                    fontSize: 24,
                    fontStyle: FontStyle.italic,
                    height: 1.35,
                    fontWeight: FontWeight.w500,
                    shadows: const [
                      Shadow(color: Colors.black54, blurRadius: 10)
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  brand,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Desenha corações subindo (loop por [phase] 0..1).
class _HeartsPainter extends CustomPainter {
  _HeartsPainter(this.phase);
  final double phase;

  static final _rnd = Random(39);
  static final List<_H> _hearts = List.generate(
      10,
      (i) => _H(
            x: _rnd.nextDouble(),
            size: 10 + _rnd.nextDouble() * 22,
            speed: 0.6 + _rnd.nextDouble() * 0.8,
            offset: _rnd.nextDouble(),
            sway: _rnd.nextDouble() * 0.06,
          ));

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    for (final h in _hearts) {
      final prog = (phase * h.speed + h.offset) % 1.0;
      final y = size.height * (1.08 - prog * 1.16);
      final x = size.width * (h.x + sin(prog * 2 * pi) * h.sway);
      // fade nas pontas
      final a = (prog < 0.15
              ? prog / 0.15
              : prog > 0.85
                  ? (1 - prog) / 0.15
                  : 1.0)
          .clamp(0.0, 1.0);
      paint.color = (h.size > 22 ? AppColors.gold : Colors.white)
          .withValues(alpha: 0.22 * a);
      _drawHeart(canvas, Offset(x, y), h.size, paint);
    }
  }

  void _drawHeart(Canvas canvas, Offset c, double s, Paint paint) {
    final path = Path();
    for (var i = 0; i <= 60; i++) {
      final t = i / 60 * 2 * pi;
      final hx = 16 * pow(sin(t), 3).toDouble();
      final hy = 13 * cos(t) -
          5 * cos(2 * t) -
          2 * cos(3 * t) -
          cos(4 * t);
      final px = c.dx + hx * s / 16;
      final py = c.dy - hy * s / 16;
      if (i == 0) {
        path.moveTo(px, py);
      } else {
        path.lineTo(px, py);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_HeartsPainter old) => old.phase != phase;
}

class _H {
  _H({
    required this.x,
    required this.size,
    required this.speed,
    required this.offset,
    required this.sway,
  });
  final double x;
  final double size;
  final double speed;
  final double offset;
  final double sway;
}
