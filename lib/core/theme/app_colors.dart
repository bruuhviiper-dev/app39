import 'package:flutter/material.dart';

/// Tokens de COR — tema ROMÂNTICO premium (vinho/plum profundo + rosé/rose-gold).
/// Mesma ESTRUTURA do template, identidade de AMOR. Nenhuma tela usa cor "solta";
/// sempre referenciar daqui. (Os tokens mantêm o nome `gold*` por compatibilidade,
/// mas o valor agora é ROSÉ.)
class AppColors {
  AppColors._();

  // Fundo (vinho/plum)
  static const bg = Color(0xFF1C0A14); // fundo principal
  static const bg2 = Color(0xFF2A0F1E); // fundo secundário
  static const surface = Color(0xFF331528); // cards
  static const surfaceHigh = Color(0xFF3F1C32); // superfície elevada

  // Marca (ROSA VIBRANTE extraído do ícone de corações) — nome `gold` preservado
  static const gold = Color(0xFFF0286A);
  static const goldDark = Color(0xFFC8104F);

  // Texto
  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFFE6C2CE);

  // Bordas
  static const border = Color(0xFF4A2740);

  /// Pílula rosé translúcida (badge "FRASE DO DIA").
  static Color get goldPill => gold.withValues(alpha: 0.16);

  /// Sobreposição branca em elementos sobre foto/gradiente.
  static Color get onPhotoSurface => Colors.white.withValues(alpha: 0.14);

  // ---- Tema CLARO (blush) ----
  static const lBg = Color(0xFFFFF0F3);
  static const lBg2 = Color(0xFFFBE2E8);
  static const lSurface = Color(0xFFFFFFFF);
  static const lSurfaceHigh = Color(0xFFFFF6F9);
  static const lTextPrimary = Color(0xFF2A0E1C);
  static const lTextSecondary = Color(0xFF8A5A6C);
  static const lBorder = Color(0xFFF2D7DF);
}

/// Cores sensíveis ao TEMA (claro/escuro). As telas de "chrome" (fundos,
/// cartões sólidos, textos, nav) usam estas; as telas sobre FOTO usam branco
/// sobre scrim (iguais nos dois temas). O dourado é o mesmo sempre.
class Palette {
  const Palette({
    required this.bg,
    required this.bg2,
    required this.surface,
    required this.surfaceHigh,
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
  });

  final Color bg;
  final Color bg2;
  final Color surface;
  final Color surfaceHigh;
  final Color textPrimary;
  final Color textSecondary;
  final Color border;

  static const _dark = Palette(
    bg: AppColors.bg,
    bg2: AppColors.bg2,
    surface: AppColors.surface,
    surfaceHigh: AppColors.surfaceHigh,
    textPrimary: AppColors.textPrimary,
    textSecondary: AppColors.textSecondary,
    border: AppColors.border,
  );

  static const _light = Palette(
    bg: AppColors.lBg,
    bg2: AppColors.lBg2,
    surface: AppColors.lSurface,
    surfaceHigh: AppColors.lSurfaceHigh,
    textPrimary: AppColors.lTextPrimary,
    textSecondary: AppColors.lTextSecondary,
    border: AppColors.lBorder,
  );

  static Palette of(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? _dark : _light;
}
