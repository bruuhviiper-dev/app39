/// Fundos ROMÂNTICOS (offline). Categorias/hero usam FOTOS reais do Pexels (licença
/// livre, sem rostos — ver ATTRIBUTIONS.md); os demais fundos ainda são arte original
/// (em renovação). Fallback elegante quando uma imagem não existir é tratado nos
/// widgets (gradiente + ícone).
class Landscapes {
  Landscapes._();

  static const _p = 'assets/landscapes/';

  static const hero = '${_p}hero_sunrise.jpg';
  static const onboarding = '${_p}onboarding.jpg';

  static const inspiration = <String>[
    '${_p}insp_peak.jpg',
    '${_p}insp_coast.jpg',
    '${_p}insp_lake.jpg',
  ];

  static String inspThumb(int i) => inspiration[i % inspiration.length];

  /// Fundos agrupados por TEMA (rótulo é chave de i18n `bgTheme.<key>`).
  static const themes = <String, List<String>>{
    'mountains': [
      '${_p}cat_motivacao.jpg',
      '${_p}insp_peak.jpg',
      '${_p}editor_bg03.jpg',
      '${_p}bg_mountains_cliff.jpg',
      '${_p}bg_misty_mountains.jpg',
      '${_p}bg_valley_sun.jpg',
    ],
    'sunrise': [
      hero,
      '${_p}cat_felicidade.jpg',
      '${_p}editor_bg04.jpg',
      '${_p}bg_sunrise_field.jpg',
      '${_p}bg_autumn.jpg',
    ],
    'forest': [
      '${_p}cat_reflexao.jpg',
      '${_p}cat_vida.jpg',
      '${_p}bg_misty_forest.jpg',
      '${_p}bg_green_hills.jpg',
    ],
    'water': [
      '${_p}cat_amor.jpg',
      '${_p}insp_coast.jpg',
      '${_p}insp_lake.jpg',
      '${_p}editor_bg05.jpg',
      '${_p}editor_bg06.jpg',
      '${_p}bg_calm_lake.jpg',
    ],
    'sky': [
      '${_p}editor_bg07.jpg',
      '${_p}editor_bg08.jpg',
      '${_p}onboarding.jpg',
    ],
    'city': [
      '${_p}cat_trabalho.jpg',
      '${_p}editor_bg01.jpg',
      '${_p}editor_bg02.jpg',
      '${_p}bg_city_geo.jpg',
      '${_p}bg_city_night.jpg',
    ],
  };

  /// Todos os fundos do EDITOR, na ordem dos temas (achatado).
  static final List<String> editorBackgrounds = [
    for (final list in themes.values) ...list,
  ];

  /// Índice (em [editorBackgrounds]) de um fundo que combina com a categoria.
  static int editorIndexForCategory(String categoryId) {
    final asset = '${_p}cat_$categoryId.jpg';
    final i = editorBackgrounds.indexOf(asset);
    return i < 0 ? 0 : i;
  }

  /// Fundos do EDITOR com versão dedicada por FORMATO (9:16 / 1:1 / 4:5) em WebP.
  /// Fotos Pexels (licença livre). O editor usa [BgAsset.of(format)] p/ enquadrar
  /// perfeito em cada formato e [BgAsset.thumb] no seletor.
  static final List<BgAsset> editorBgs = [
    for (var i = 1; i <= 18; i++) BgAsset(i.toString().padLeft(2, '0')),
  ];
}

/// Um fundo do editor em 3 formatos + miniatura (ver [Landscapes.editorBgs]).
class BgAsset {
  const BgAsset(this.n);
  final String n; // '01'..'18'

  String get thumb => 'assets/backgrounds/thumbs/bg$n.webp';

  /// Caminho do fundo no formato do editor: 0 = 9:16 (story), 1 = 1:1 (feed),
  /// 2 = 4:5 (status).
  String of(int format) {
    const dir = ['r916', 'r11', 'r45'];
    final d = (format >= 0 && format < dir.length) ? dir[format] : 'r916';
    return 'assets/backgrounds/$d/bg$n.webp';
  }
}
