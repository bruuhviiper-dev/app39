import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'rate_prompt.dart';

/// Estado global: favoritos + preferências (tema, idioma, tamanho de fonte,
/// notificações, onboarding). Tudo persistido localmente (SharedPreferences).
/// Favoritar é AÇÃO POSITIVA → alimenta o prompt de avaliação do Google.
class AppState extends ChangeNotifier {
  AppState(this._prefs) {
    _load();
  }

  final SharedPreferences _prefs;

  static const _kFavorites = 'favorites';
  static const _kThemeMode = 'theme_mode';
  static const _kLocale = 'locale_code';
  static const _kFontScale = 'font_scale';
  static const _kNotifications = 'notifications_on';
  static const _kOnboarding = 'onboarding_done';
  static const _kEntitlements = 'entitlements';
  static const _kTempPro = 'temp_pro_until';
  static const _kPartnerName = 'partner_name';
  static const _kRelStart = 'rel_start_ms';
  static const _kChallengeDone = 'challenge_done_days';
  static const _kChallengeLast = 'challenge_last_date';

  /// Produto de compra única "remover anúncios" — mesmo id do app2/app26.
  static const String pRemoveAds = 'no_ads';

  final Set<String> _favorites = {};
  ThemeMode _themeMode = ThemeMode.dark;
  String? _localeCode; // null = seguir o aparelho
  double _fontScale = 1.0;
  bool _notificationsOn = false;
  bool _onboardingDone = false;
  final Set<String> _entitlements = {};
  DateTime? _tempProUntil;
  String _partnerName = '';
  DateTime? _relStart;
  final Set<int> _challengeDone = {};
  String? _challengeLast; // yyyy-mm-dd da última conclusão

  // ----- favoritos -----
  Set<String> get favorites => Set.unmodifiable(_favorites);
  bool get hasFavorites => _favorites.isNotEmpty;
  bool isFavorite(String id) => _favorites.contains(id);

  /// Alterna o favorito e persiste. Retorna `true` se ficou FAVORITADO.
  bool toggleFavorite(String id) {
    final bool added;
    if (_favorites.remove(id)) {
      added = false;
    } else {
      _favorites.add(id);
      added = true;
    }
    _prefs.setStringList(_kFavorites, _favorites.toList());
    notifyListeners();
    if (added) RatePrompt.registerPositiveAction();
    return added;
  }

  // ----- tema -----
  ThemeMode get themeMode => _themeMode;
  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    _prefs.setInt(_kThemeMode, mode.index);
    notifyListeners();
  }

  // ----- idioma -----
  /// `null` = seguir o idioma do aparelho.
  String? get localeCode => _localeCode;
  Locale? get localeOverride =>
      _localeCode == null ? null : Locale(_localeCode!);
  void setLocaleCode(String? code) {
    _localeCode = code;
    if (code == null) {
      _prefs.remove(_kLocale);
    } else {
      _prefs.setString(_kLocale, code);
    }
    notifyListeners();
  }

  // ----- tamanho da fonte -----
  double get fontScale => _fontScale;
  void setFontScale(double scale) {
    _fontScale = scale;
    _prefs.setDouble(_kFontScale, scale);
    notifyListeners();
  }

  // ----- notificações (preferência; agendamento no NotificationService) -----
  bool get notificationsOn => _notificationsOn;
  void setNotificationsOn(bool on) {
    _notificationsOn = on;
    _prefs.setBool(_kNotifications, on);
    notifyListeners();
  }

  // ----- onboarding -----
  bool get onboardingDone => _onboardingDone;
  void completeOnboarding() {
    _onboardingDone = true;
    _prefs.setBool(_kOnboarding, true);
    notifyListeners();
  }

  // ----- compras / anúncios -----
  bool ownsProduct(String id) => _entitlements.contains(id);

  void grantEntitlement(String id) {
    if (_entitlements.add(id)) {
      _prefs.setStringList(_kEntitlements, _entitlements.toList());
      notifyListeners();
    }
  }

  /// PRO temporário liberado por VÍDEO premiado (ex.: 24h sem anúncios).
  bool get hasTemporaryPro =>
      _tempProUntil != null && _tempProUntil!.isAfter(DateTime.now());
  void grantTemporaryPro(Duration d) {
    _tempProUntil = DateTime.now().add(d);
    _prefs.setInt(_kTempPro, _tempProUntil!.millisecondsSinceEpoch);
    notifyListeners();
  }

  /// Vê o app sem anúncios: comprou "remover anúncios" OU está no PRO temporário.
  bool get adsRemoved => _entitlements.contains(pRemoveAds) || hasTemporaryPro;

  // ----- nome do par (personalização) -----
  String get partnerName => _partnerName;
  bool get hasPartnerName => _partnerName.trim().isNotEmpty;
  void setPartnerName(String name) {
    _partnerName = name.trim();
    _prefs.setString(_kPartnerName, _partnerName);
    notifyListeners();
  }

  // ----- modo casal: data de início do relacionamento -----
  DateTime? get relationshipStart => _relStart;
  bool get hasRelationship => _relStart != null;

  /// Dias juntos (0 se não definido).
  int get daysTogether {
    if (_relStart == null) return 0;
    final now = DateTime.now();
    final a = DateTime(_relStart!.year, _relStart!.month, _relStart!.day);
    final b = DateTime(now.year, now.month, now.day);
    return b.difference(a).inDays;
  }

  void setRelationshipStart(DateTime? d) {
    _relStart = d;
    if (d == null) {
      _prefs.remove(_kRelStart);
    } else {
      _prefs.setInt(_kRelStart, d.millisecondsSinceEpoch);
    }
    notifyListeners();
  }

  // ----- desafio 30 dias -----
  Set<int> get challengeDone => Set.unmodifiable(_challengeDone);
  int get challengeCount => _challengeDone.length;
  bool isChallengeDone(int day) => _challengeDone.contains(day);

  /// Próximo dia do desafio a fazer (1..30), ou 0 se completou os 30.
  int get challengeCurrentDay {
    for (var d = 1; d <= 30; d++) {
      if (!_challengeDone.contains(d)) return d;
    }
    return 0;
  }

  /// Já concluiu um dia hoje? (um por dia de calendário).
  bool get challengeDoneToday => _challengeLast == _today();

  /// Marca o dia como concluído (uma vez por dia). Ação positiva → review.
  void completeChallengeDay(int day) {
    if (_challengeDone.add(day)) {
      _challengeLast = _today();
      _prefs.setStringList(
          _kChallengeDone, _challengeDone.map((e) => '$e').toList());
      _prefs.setString(_kChallengeLast, _challengeLast!);
      notifyListeners();
      RatePrompt.registerPositiveAction();
    }
  }

  static String _today() {
    final n = DateTime.now();
    return '${n.year}-${n.month.toString().padLeft(2, '0')}-'
        '${n.day.toString().padLeft(2, '0')}';
  }

  void _load() {
    _favorites.addAll(_prefs.getStringList(_kFavorites) ?? const []);
    final tm = _prefs.getInt(_kThemeMode);
    if (tm != null && tm >= 0 && tm < ThemeMode.values.length) {
      _themeMode = ThemeMode.values[tm];
    }
    _localeCode = _prefs.getString(_kLocale);
    _fontScale = _prefs.getDouble(_kFontScale) ?? 1.0;
    _notificationsOn = _prefs.getBool(_kNotifications) ?? false;
    _onboardingDone = _prefs.getBool(_kOnboarding) ?? false;
    _entitlements.addAll(_prefs.getStringList(_kEntitlements) ?? const []);
    final tp = _prefs.getInt(_kTempPro);
    _tempProUntil = tp != null ? DateTime.fromMillisecondsSinceEpoch(tp) : null;
    _partnerName = _prefs.getString(_kPartnerName) ?? '';
    final rs = _prefs.getInt(_kRelStart);
    _relStart = rs != null ? DateTime.fromMillisecondsSinceEpoch(rs) : null;
    _challengeDone.addAll((_prefs.getStringList(_kChallengeDone) ?? const [])
        .map(int.tryParse)
        .whereType<int>());
    _challengeLast = _prefs.getString(_kChallengeLast);
  }
}
