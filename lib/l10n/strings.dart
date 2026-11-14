import 'package:flutter/material.dart';

/// Internacionalização da UI — pronta para 64 idiomas.
///
/// Arquitetura: um mapa `lang -> (chave -> texto)`. Hoje traz PT e EN; cada novo
/// idioma é só mais um mapa (ou um JSON por locale em `assets/l10n/`). A busca
/// faz fallback: idioma do aparelho -> inglês -> português -> a própria chave.
/// Assim nenhuma tela quebra enquanto as 64 traduções são preenchidas.
class T {
  const T(this.locale);
  final Locale locale;

  static T of(BuildContext context) =>
      Localizations.of<T>(context, T) ?? const T(Locale('en'));

  /// Código do idioma atual (para carregar o CONTEÚDO por locale).
  String get lang => locale.languageCode;

  /// Nome do app — traduzido por idioma (ver `app.name`).
  String get appName => _('app.name');

  String _(String key) {
    final lang = locale.languageCode;
    return _data[lang]?[key] ?? _data['en']![key] ?? _data['pt']![key] ?? key;
  }

  // Cabeçalho
  String get appSubtitle => _('app.subtitle');
  String get notifications => _('notifications');

  // Frase do dia
  String get verseOfDay => _('verseOfDay');
  String get dailyInspiration => _('dailyInspiration');
  String get share => _('share');
  String get save => _('save');
  String get newVerse => _('newVerse');
  String get savedToFavorites => _('savedToFavorites');
  String get removedFromFavorites => _('removedFromFavorites');

  // Seções
  String get exploreByCategory => _('exploreByCategory');
  String get seeAll => _('seeAll');
  String get moreInspirations => _('moreInspirations');

  // Navegação
  String get navHome => _('navHome');
  String get navExplore => _('navExplore');
  String get navFavorites => _('navFavorites');
  String get navSettings => _('navSettings');
  String get navCategories => _('navCategories');
  String get navMore => _('navMore');

  // Categorias
  String get categoriesTitle => _('categoriesTitle');
  String get filterAll => _('filterAll');
  String get filterPopular => _('filterPopular');
  String get filterNew => _('filterNew');
  String versesCount(int n) =>
      '$n ${_(n == 1 ? 'verse.one' : 'verse.many')}';

  // Detalhe
  String get copy => _('copy');
  String get copied => _('copied');
  String get favorite => _('favorite');

  // Notificação (texto GENÉRICO — nunca revela a frase)
  String get notifBody => _('notifBody');

  // Loja (remover anúncios)
  String get removeAdsTitle => _('removeAdsTitle');
  String get removeAdsHero => _('removeAdsHero');
  String get removeAdsDesc => _('removeAdsDesc');
  String get removeAdsCta => _('removeAdsCta');
  String get adsRemovedTitle => _('adsRemovedTitle');
  String get adsRemovedDesc => _('adsRemovedDesc');
  String get watchVideoAdFree => _('watchVideoAdFree');
  String get restorePurchase => _('restorePurchase');
  String get processing => _('processing');
  String get purchaseSuccess => _('purchaseSuccess');
  String get purchaseFailed => _('purchaseFailed');
  String get adFreeFor24h => _('adFreeFor24h');
  String get freeBenefitsTitle => _('freeBenefitsTitle');
  String get benefitThemes => _('benefitThemes');
  String get benefitEditor => _('benefitEditor');
  String get benefitContent => _('benefitContent');
  String get benefitOffline => _('benefitOffline');

  // Editor de imagem
  String get createImage => _('createImage');
  String get editImage => _('editImage');
  String get shareImage => _('shareImage');
  String get savedToGallery => _('savedToGallery');
  String get saveError => _('saveError');
  String get backgroundsLabel => _('backgroundsLabel');
  String get filtersLabel => _('filtersLabel');
  String get adjustmentsLabel => _('adjustmentsLabel');
  String get textLabel => _('textLabel');
  String get brightness => _('brightness');
  String get contrast => _('contrast');
  String get saturation => _('saturation');
  String get intensity => _('intensity');
  String get textSize => _('textSize');
  String get textColor => _('textColor');
  String get alignment => _('alignment');
  String get reset => _('reset');
  String get undo => _('undo');
  String get redo => _('redo');
  String get fmtStory => _('fmtStory');
  String get fmtFeed => _('fmtFeed');
  String get fmtStatus => _('fmtStatus');
  String get filterNone => _('filterNone');
  String get filterBlue => _('filterBlue');
  String get filterYellow => _('filterYellow');
  String get filterRed => _('filterRed');
  String get filterVintage => _('filterVintage');
  String get filterBW => _('filterBW');
  String get filterWarm => _('filterWarm');
  String get filterNoir => _('filterNoir');
  String get filterFade => _('filterFade');
  String get filterDrama => _('filterDrama');
  String get filterMint => _('filterMint');
  String get filterPurple => _('filterPurple');
  // Tipos de fundo do editor
  String get bgPhotos => _('bgPhotos');
  String get bgColors => _('bgColors');
  String get bgGradients => _('bgGradients');
  String get bgTextures => _('bgTextures');
  // Texturas
  String get texNone => _('texNone');
  String get texGrain => _('texGrain');
  String get texDots => _('texDots');
  String get texLines => _('texLines');
  String get texBokeh => _('texBokeh');
  String get texGlow => _('texGlow');
  String get texVignette => _('texVignette');

  // Favoritos
  String get favoritesTitle => _('favoritesTitle');
  String get favText => _('favText');
  String get favByCategory => _('favByCategory');
  String get emptyFavorites => _('emptyFavorites');
  String get emptyFavoritesHint => _('emptyFavoritesHint');

  // Pesquisa
  String get searchTitle => _('searchTitle');
  String get searchHint => _('searchHint');
  String get popularSuggestions => _('popularSuggestions');
  String get results => _('results');
  String get searchPrompt => _('searchPrompt');
  String noResults(String q) => _('noResults').replaceFirst('{q}', q);

  // Configurações
  String get settingsTitle => _('settingsTitle');
  String get language => _('language');
  String get systemDefault => _('systemDefault');
  String get notificationsLabel => _('notificationsLabel');
  String get notificationsDesc => _('notificationsDesc');
  String get theme => _('theme');
  String get themeSystem => _('themeSystem');
  String get themeLight => _('themeLight');
  String get themeDark => _('themeDark');
  String get fontSize => _('fontSize');
  String get fontSmall => _('fontSmall');
  String get fontDefault => _('fontDefault');
  String get fontLarge => _('fontLarge');
  String get about => _('about');
  String get shareApp => _('shareApp');
  String get rateApp => _('rateApp');
  String get privacy => _('privacy');
  String get terms => _('terms');
  String get privacyBody => _('privacyBody');
  String get termsBody => _('termsBody');
  String get version => _('version');
  String get preferences => _('preferences');
  String get general => _('general');

  // Onboarding
  String get onbSubtitle => _('onbSubtitle');
  String get onbSub2 => _('onbSub2');
  String get onbSub3 => _('onbSub3');
  String get skip => _('skip');
  String get start => _('start');
  String get next => _('next');
  String get splashTagline => _('app.subtitle');

  // Estados
  String get loading => _('loading');
  String get emptyVerses => _('emptyVerses');
  String get errorLoading => _('errorLoading');
  String get retry => _('retry');
  String get comingSoon => _('comingSoon');

  // Categorias (resolvidas por id)
  String catName(String id) => _('cat.$id.name');

  // ---- Nós / casal (features de diferenciação) ----
  String get navCouple => _('nav.couple');
  String get coupleTagline => _('couple.tagline');
  String get coupleNameLabel => _('couple.nameLabel');
  String get coupleDateLabel => _('couple.dateLabel');
  String get coupleTapToSet => _('couple.tapToSet');
  String get coupleDaysWord => _('couple.daysWord');
  String get coupleNoDate => _('couple.noDate');
  String get coupleNextMonthsary => _('couple.nextMonthsary'); // {n}
  String get coupleNextAnniversary => _('couple.nextAnniversary'); // {n}
  String get coupleTodaySpecial => _('couple.todaySpecial');
  String get cardGenerator => _('card.generator');
  String get cardGeneratorDesc => _('card.generatorDesc');
  String get cardQuestions => _('card.questions');
  String get cardQuestionsDesc => _('card.questionsDesc');
  String get cardChallenge => _('card.challenge');
  String get cardChallengeDesc => _('card.challengeDesc');
  String get dlgSave => _('dlg.save');
  String get dlgClear => _('dlg.clear');
  String get namePromptHint => _('name.hint');
  // Gerador
  String get genTitle => _('gen.title');
  String get genChooseTone => _('gen.chooseTone');
  String get genPersonalized => _('gen.personalized'); // {name}
  String get genSetNameHint => _('gen.setNameHint');
  String get genGenerate => _('gen.generate');
  String get genRegenerate => _('gen.regenerate');
  String get genEmpty => _('gen.empty');
  String toneName(String k) => _('tone.$k');
  // Perguntas
  String get qTitle => _('q.title');
  String get qIntro => _('q.intro');
  String get qNext => _('q.next');
  // Desafio
  String get chTitle => _('ch.title');
  String get chDayWord => _('ch.dayWord');
  String get chProgress => _('ch.progress'); // {n}
  String get chMarkDone => _('ch.markDone');
  String get chDoneWord => _('ch.doneWord');
  String get chComeTomorrow => _('ch.comeTomorrow');
  String get chComplete => _('ch.complete');
  String get chLocked => _('ch.locked');
  // Cartinhas programadas
  String get cardLetters => _('card.letters');
  String get cardLettersDesc => _('card.lettersDesc');
  String get lettersTitle => _('letters.title');
  String get lettersEmpty => _('letters.empty');
  String get lettersNew => _('letters.new');
  String get letterWriteHint => _('letters.writeHint');
  String get letterRevealLabel => _('letters.revealLabel');
  String get letterLockedIn => _('letters.lockedIn'); // {n}
  String get letterOpensToday => _('letters.opensToday');
  String get letterSealed => _('letters.sealed');
  String get letterSave => _('letters.save');
  String get letterNeedFuture => _('letters.needFuture');
  String get delete => _('letters.delete');
  // Lembrete "mande um carinho"
  String get careReminderLabel => _('care.label');
  String get careReminderDesc => _('care.desc');
  String get careNotifBody => _('care.notifBody');
  String get sendWhatsapp => _('care.whatsapp');
  // Widget dias juntos
  String get widgetDaysLabel => _('widget.daysLabel');
  // Cartão animado (story GIF)
  String get cardAnimated => _('card.animated');
  String get cardAnimatedDesc => _('card.animatedDesc');
  String get animExport => _('anim.export');
  String get animExporting => _('anim.exporting');
  String get animDone => _('anim.done');
  String catDesc(String id) => _('cat.$id.desc');

  static const Map<String, Map<String, String>> _data = {
    'pt': {
      'app.name': 'Mensagens de Amor',
      'app.subtitle': 'Mensagens de amor para todos os dias.',
      'notifications': 'Notificações',
      'verseOfDay': 'FRASE DO DIA',
      'dailyInspiration': 'Inspiração diária',
      'share': 'Compartilhar',
      'save': 'Salvar',
      'newVerse': 'Nova frase',
      'savedToFavorites': 'Salvo nos favoritos',
      'removedFromFavorites': 'Removido dos favoritos',
      'exploreByCategory': 'Explore por categoria',
      'seeAll': 'Ver todas',
      'moreInspirations': 'Mais inspirações',
      'navHome': 'Início',
      'navExplore': 'Explorar',
      'navFavorites': 'Favoritos',
      'navSettings': 'Ajustes',
      'navCategories': 'Categorias',
      'navMore': 'Mais',
      'categoriesTitle': 'Categorias',
      'filterAll': 'Todas',
      'filterPopular': 'Mais populares',
      'filterNew': 'Novas',
      'verse.one': 'frase',
      'verse.many': 'frases',
      'notifBody': 'Toque para ver a sua frase de hoje 🌅',
      'removeAdsTitle': 'Remover anúncios',
      'removeAdsHero': 'Use o app sem anúncios',
      'removeAdsDesc': 'Pagamento único, para sempre. Sem assinaturas.',
      'removeAdsCta': 'Remover anúncios',
      'adsRemovedTitle': 'Você já removeu os anúncios!',
      'adsRemovedDesc': 'Obrigado pelo apoio 🙏 Aproveite sem interrupções.',
      'watchVideoAdFree': 'Assistir vídeo (24h sem anúncios)',
      'restorePurchase': 'Restaurar compra',
      'processing': 'Processando…',
      'purchaseSuccess': 'Tudo certo! Anúncios removidos. 🎉',
      'purchaseFailed': 'Não foi possível concluir a compra.',
      'adFreeFor24h': 'Sem anúncios por 24 horas! ✨',
      'freeBenefitsTitle': 'TUDO ISTO É GRÁTIS',
      'benefitThemes': 'Tema claro e escuro',
      'benefitEditor': 'Editor de imagem com filtros',
      'benefitContent': 'Todas as categorias e frases',
      'benefitOffline': 'Funciona offline, no seu idioma',
      'copy': 'Copiar',
      'copied': 'Frase copiada',
      'favorite': 'Favoritar',
      'createImage': 'Criar imagem',
      'editImage': 'Editar',
      'shareImage': 'Compartilhar imagem',
      'savedToGallery': 'Imagem salva na galeria',
      'saveError': 'Não foi possível salvar a imagem',
      'backgroundsLabel': 'Fundo',
      'filtersLabel': 'Filtros',
      'adjustmentsLabel': 'Ajustes',
      'textLabel': 'Texto',
      'brightness': 'Brilho',
      'contrast': 'Contraste',
      'saturation': 'Saturação',
      'intensity': 'Intensidade',
      'textSize': 'Tamanho',
      'textColor': 'Cor',
      'alignment': 'Alinhamento',
      'reset': 'Resetar',
      'undo': 'Desfazer',
      'redo': 'Refazer',
      'fmtStory': 'Story',
      'fmtFeed': 'Feed',
      'fmtStatus': 'Status',
      'filterNone': 'Original',
      'filterBlue': 'Azulado',
      'filterYellow': 'Amarelado',
      'filterRed': 'Avermelhado',
      'filterVintage': 'Vintage',
      'filterBW': 'P&B',
      'filterWarm': 'Quente',
      'filterNoir': 'Noir',
      'filterFade': 'Desbotado',
      'filterDrama': 'Drama',
      'filterMint': 'Menta',
      'filterPurple': 'Roxo',
      'bgPhotos': 'Fotos',
      'bgColors': 'Cores',
      'bgGradients': 'Degradês',
      'bgTextures': 'Texturas',
      'texNone': 'Nenhuma',
      'texGrain': 'Grão',
      'texDots': 'Pontos',
      'texLines': 'Linhas',
      'texBokeh': 'Bokeh',
      'texGlow': 'Brilho',
      'texVignette': 'Vinheta',
      'favoritesTitle': 'Favoritos',
      'favText': 'Texto',
      'favByCategory': 'Por categoria',
      'emptyFavorites': 'Você ainda não salvou nenhuma frase.',
      'emptyFavoritesHint': 'Toque no coração para guardar as que mais gostar.',
      'searchTitle': 'Buscar',
      'searchHint': 'Digite uma palavra-chave...',
      'popularSuggestions': 'Sugestões populares',
      'results': 'Resultados',
      'searchPrompt': 'Pesquise por tema, palavra ou categoria.',
      'noResults': 'Nenhum resultado para "{q}".',
      'settingsTitle': 'Configurações',
      'language': 'Idioma',
      'systemDefault': 'Padrão do sistema',
      'notificationsLabel': 'Notificações',
      'notificationsDesc': 'Receba uma inspiração por dia',
      'theme': 'Tema',
      'themeSystem': 'Automático',
      'themeLight': 'Claro',
      'themeDark': 'Escuro',
      'fontSize': 'Tamanho da fonte',
      'fontSmall': 'Pequeno',
      'fontDefault': 'Padrão',
      'fontLarge': 'Grande',
      'about': 'Sobre o app',
      'shareApp': 'Compartilhar app',
      'rateApp': 'Avaliar na Play Store',
      'privacy': 'Política de Privacidade',
      'terms': 'Termos de Uso',
      'privacyBody':
          'Respeitamos a sua privacidade. Este aplicativo funciona totalmente '
              'offline e NÃO coleta, armazena nem compartilha dados pessoais.\n\n'
              '• Preferências e favoritos ficam salvos apenas no seu aparelho.\n'
              '• Não exigimos cadastro, login ou acesso à sua localização, '
              'contatos ou arquivos.\n'
              '• Podemos exibir anúncios do Google AdMob. O AdMob pode usar '
              'identificadores do dispositivo para mostrar anúncios; consulte a '
              'política do Google em policies.google.com/privacy. Você pode '
              'remover os anúncios com a compra dentro do app.\n'
              '• Imagens criadas são salvas apenas onde você escolher '
              'compartilhar ou guardar.\n\n'
              'Em caso de dúvidas sobre privacidade, entre em contato pelo '
              'e-mail de suporte informado na Play Store.',
      'termsBody':
          'Ao usar este aplicativo, você concorda com estes termos.\n\n'
              '• O app é fornecido "como está", para uso pessoal e não '
              'comercial, com fins de inspiração e entretenimento.\n'
              '• As frases e imagens podem ser compartilhadas livremente para '
              'uso pessoal; não as revenda como um produto concorrente.\n'
              '• Não nos responsabilizamos por decisões tomadas com base no '
              'conteúdo exibido.\n'
              '• Podemos atualizar recursos, conteúdo e estes termos a qualquer '
              'momento, com a nova versão publicada na Play Store.\n\n'
              'Se não concordar com os termos, basta desinstalar o aplicativo.',
      'version': 'Versão',
      'preferences': 'PREFERÊNCIAS',
      'general': 'GERAL',
      'onbSubtitle':
          'Mensagens de amor para aquecer o coração todos os dias.',
      'onbSub2':
          'Salve as suas favoritas e envie para quem você ama.',
      'onbSub3': 'Crie imagens lindas e compartilhe o seu amor — offline.',
      'skip': 'Pular',
      'start': 'Começar',
      'next': 'Avançar',
      'loading': 'Carregando...',
      'emptyVerses': 'Nenhuma frase disponível ainda.',
      'errorLoading': 'Não foi possível carregar o conteúdo.',
      'retry': 'Tentar de novo',
      'comingSoon': 'Em breve',
      'cat.declaracao.name': 'Declarações de Amor',
      'cat.declaracao.desc': 'Diga o que o coração sente',
      'cat.te_amo.name': 'Eu Te Amo',
      'cat.te_amo.desc': 'Três palavras, mil sentimentos',
      'cat.bomdia.name': 'Bom Dia, Amor',
      'cat.bomdia.desc': 'Comece o dia com carinho',
      'cat.boanoite.name': 'Boa Noite, Amor',
      'cat.boanoite.desc': 'Durma pensando em mim',
      'cat.saudade.name': 'Saudade',
      'cat.saudade.desc': 'Quando a distância aperta o peito',
      'cat.paixao.name': 'Paixão',
      'cat.paixao.desc': 'O fogo que arde por você',
      'cat.namoro.name': 'Namoro',
      'cat.namoro.desc': 'O amor de todo dia',
      'cat.distancia.name': 'Amor à Distância',
      'cat.distancia.desc': 'Perto no coração',
      'cat.reconciliacao.name': 'Reconciliação',
      'cat.reconciliacao.desc': 'Um pedido sincero',
      'cat.casamento.name': 'Para Sempre',
      'cat.casamento.desc': 'Um amor sem fim',
      'cat.cantadas.name': 'Cantadas',
      'cat.cantadas.desc': 'Para arrancar um sorriso',
      'cat.gratidao.name': 'Gratidão pelo Amor',
      'cat.gratidao.desc': 'Obrigado por você',
      'nav.couple': 'Nós',
      'couple.tagline': 'Tudo sobre o amor de vocês',
      'couple.nameLabel': 'Nome do seu amor',
      'couple.dateLabel': 'Começamos a namorar em',
      'couple.tapToSet': 'Toque para definir',
      'couple.daysWord': 'dias juntos',
      'couple.noDate': 'Defina a data em que vocês começaram para ver os dias juntos.',
      'couple.nextMonthsary': 'Faltam {n} dias para o seu mêsversário 💞',
      'couple.nextAnniversary': 'Faltam {n} dias para o aniversário de namoro 🎉',
      'couple.todaySpecial': 'Hoje é um dia especial de vocês! 🎉',
      'card.generator': 'Gerador de mensagem',
      'card.generatorDesc': 'Crie uma mensagem única',
      'card.questions': 'Perguntas para o casal',
      'card.questionsDesc': 'Aproximem-se conversando',
      'card.challenge': 'Desafio 30 dias',
      'card.challengeDesc': 'Um gesto de amor por dia',
      'dlg.save': 'Salvar',
      'dlg.clear': 'Limpar',
      'name.hint': 'Ex.: Maria',
      'gen.title': 'Gerador de mensagem',
      'gen.chooseTone': 'Escolha o tom',
      'gen.personalized': 'Personalizado para {name}',
      'gen.setNameHint': 'Defina o nome do seu amor para personalizar',
      'gen.generate': 'Gerar mensagem',
      'gen.regenerate': 'Gerar outra',
      'gen.empty': 'Escolha um tom e toque em Gerar.',
      'tone.romantico': 'Romântico',
      'tone.fofo': 'Fofo / Bom dia',
      'tone.saudade': 'Saudade',
      'tone.desculpas': 'Desculpas',
      'tone.engracado': 'Engraçado',
      'tone.compromisso': 'Compromisso',
      'tone.gratidao': 'Gratidão',
      'q.title': 'Perguntas para o casal',
      'q.intro': 'Uma pergunta para aproximar vocês',
      'q.next': 'Próxima pergunta',
      'ch.title': 'Desafio 30 dias de amor',
      'ch.dayWord': 'Dia',
      'ch.progress': '{n}/30 concluídos',
      'ch.markDone': 'Marcar como feito',
      'ch.doneWord': 'Feito',
      'ch.comeTomorrow': 'Volte amanhã para o próximo desafio 💞',
      'ch.complete': 'Vocês completaram os 30 dias de amor! 💞',
      'ch.locked': 'Complete o dia anterior primeiro',
      'card.letters': 'Cartinhas programadas',
      'card.lettersDesc': 'Mensagens que abrem numa data',
      'letters.title': 'Cartinhas programadas',
      'letters.empty': 'Escreva uma cartinha que só vai abrir na data que você escolher. 💌',
      'letters.new': 'Nova cartinha',
      'letters.writeHint': 'Escreva a sua mensagem de amor...',
      'letters.revealLabel': 'Abrir em',
      'letters.lockedIn': 'Abre em {n} dias 🔒',
      'letters.opensToday': 'Abre hoje! 💌',
      'letters.sealed': 'Cartinha lacrada',
      'letters.save': 'Guardar cartinha',
      'letters.needFuture': 'Escolha uma data futura.',
      'letters.delete': 'Apagar',
      'care.label': 'Lembrete de carinho',
      'care.desc': 'Um empurrãozinho diário para mandar amor',
      'care.notifBody': 'Que tal mandar um carinho agora? 💕',
      'care.whatsapp': 'Enviar no WhatsApp',
      'widget.daysLabel': 'dias juntos',
      'card.animated': 'Cartão animado',
      'card.animatedDesc': 'Um story que se mexe 💞',
      'anim.export': 'Salvar GIF e compartilhar',
      'anim.exporting': 'Gerando o seu GIF...',
      'anim.done': 'GIF salvo na galeria! 💞',

    },
    'en': {
      'app.name': 'Love Messages',
      'app.subtitle': 'Love messages for every day.',
      'notifications': 'Notifications',
      'verseOfDay': 'QUOTE OF THE DAY',
      'dailyInspiration': 'Daily inspiration',
      'share': 'Share',
      'save': 'Save',
      'newVerse': 'New quote',
      'savedToFavorites': 'Saved to favorites',
      'removedFromFavorites': 'Removed from favorites',
      'exploreByCategory': 'Explore by category',
      'seeAll': 'See all',
      'moreInspirations': 'More inspirations',
      'navHome': 'Home',
      'navExplore': 'Explore',
      'navFavorites': 'Favorites',
      'navSettings': 'Settings',
      'navCategories': 'Categories',
      'navMore': 'More',
      'categoriesTitle': 'Categories',
      'filterAll': 'All',
      'filterPopular': 'Most popular',
      'filterNew': 'New',
      'verse.one': 'quote',
      'verse.many': 'quotes',
      'notifBody': 'Tap to see your quote for today 🌅',
      'removeAdsTitle': 'Remove ads',
      'removeAdsHero': 'Enjoy the app ad-free',
      'removeAdsDesc': 'One-time payment, forever. No subscriptions.',
      'removeAdsCta': 'Remove ads',
      'adsRemovedTitle': 'Ads already removed!',
      'adsRemovedDesc': 'Thanks for your support 🙏 Enjoy without interruptions.',
      'watchVideoAdFree': 'Watch a video (24h ad-free)',
      'restorePurchase': 'Restore purchase',
      'processing': 'Processing…',
      'purchaseSuccess': 'All set! Ads removed. 🎉',
      'purchaseFailed': 'Could not complete the purchase.',
      'adFreeFor24h': 'Ad-free for 24 hours! ✨',
      'freeBenefitsTitle': 'ALL OF THIS IS FREE',
      'benefitThemes': 'Light and dark theme',
      'benefitEditor': 'Image editor with filters',
      'benefitContent': 'All categories and quotes',
      'benefitOffline': 'Works offline, in your language',
      'copy': 'Copy',
      'copied': 'Quote copied',
      'favorite': 'Favorite',
      'createImage': 'Create image',
      'editImage': 'Edit',
      'shareImage': 'Share image',
      'savedToGallery': 'Image saved to gallery',
      'saveError': "Couldn't save the image",
      'backgroundsLabel': 'Background',
      'filtersLabel': 'Filters',
      'adjustmentsLabel': 'Adjust',
      'textLabel': 'Text',
      'brightness': 'Brightness',
      'contrast': 'Contrast',
      'saturation': 'Saturation',
      'intensity': 'Intensity',
      'textSize': 'Size',
      'textColor': 'Color',
      'alignment': 'Alignment',
      'reset': 'Reset',
      'undo': 'Undo',
      'redo': 'Redo',
      'fmtStory': 'Story',
      'fmtFeed': 'Feed',
      'fmtStatus': 'Status',
      'filterNone': 'Original',
      'filterBlue': 'Cool',
      'filterYellow': 'Warm',
      'filterRed': 'Sunset',
      'filterVintage': 'Vintage',
      'filterBW': 'B&W',
      'filterWarm': 'Warm',
      'filterNoir': 'Noir',
      'filterFade': 'Fade',
      'filterDrama': 'Drama',
      'filterMint': 'Mint',
      'filterPurple': 'Purple',
      'bgPhotos': 'Photos',
      'bgColors': 'Colors',
      'bgGradients': 'Gradients',
      'bgTextures': 'Textures',
      'texNone': 'None',
      'texGrain': 'Grain',
      'texDots': 'Dots',
      'texLines': 'Lines',
      'texBokeh': 'Bokeh',
      'texGlow': 'Glow',
      'texVignette': 'Vignette',
      'favoritesTitle': 'Favorites',
      'favText': 'Text',
      'favByCategory': 'By category',
      'emptyFavorites': "You haven't saved any quotes yet.",
      'emptyFavoritesHint': 'Tap the heart to keep the ones you love.',
      'searchTitle': 'Search',
      'searchHint': 'Type a keyword...',
      'popularSuggestions': 'Popular suggestions',
      'results': 'Results',
      'searchPrompt': 'Search by theme, word or category.',
      'noResults': 'No results for "{q}".',
      'settingsTitle': 'Settings',
      'language': 'Language',
      'systemDefault': 'System default',
      'notificationsLabel': 'Notifications',
      'notificationsDesc': 'Get a daily dose of inspiration',
      'theme': 'Theme',
      'themeSystem': 'Automatic',
      'themeLight': 'Light',
      'themeDark': 'Dark',
      'fontSize': 'Font size',
      'fontSmall': 'Small',
      'fontDefault': 'Default',
      'fontLarge': 'Large',
      'about': 'About',
      'shareApp': 'Share app',
      'rateApp': 'Rate on Play Store',
      'privacy': 'Privacy Policy',
      'terms': 'Terms of Use',
      'privacyBody':
          'We respect your privacy. This app works fully offline and does NOT '
              'collect, store or share personal data.\n\n'
              '• Preferences and favorites are saved only on your device.\n'
              '• We do not require sign-up, login or access to your location, '
              'contacts or files.\n'
              '• We may show ads via Google AdMob. AdMob may use device '
              'identifiers to serve ads; see Google\'s policy at '
              'policies.google.com/privacy. You can remove ads with the in-app '
              'purchase.\n'
              '• Images you create are saved only where you choose to share or '
              'store them.\n\n'
              'For any privacy questions, contact us at the support e-mail '
              'listed on the Play Store.',
      'termsBody':
          'By using this app, you agree to these terms.\n\n'
              '• The app is provided "as is", for personal, non-commercial use, '
              'for inspiration and entertainment.\n'
              '• Quotes and images may be shared freely for personal use; do '
              'not resell them as a competing product.\n'
              '• We are not liable for decisions made based on the content '
              'shown.\n'
              '• We may update features, content and these terms at any time, '
              'with the new version published on the Play Store.\n\n'
              'If you do not agree with the terms, simply uninstall the app.',
      'version': 'Version',
      'preferences': 'PREFERENCES',
      'general': 'GENERAL',
      'onbSubtitle': 'Love messages to warm your heart every day.',
      'onbSub2': 'Save your favorites and send them to the one you love.',
      'onbSub3': 'Create beautiful images and share your love — offline.',
      'skip': 'Skip',
      'start': 'Get started',
      'next': 'Next',
      'loading': 'Loading...',
      'emptyVerses': 'No quotes available yet.',
      'errorLoading': 'We could not load the content.',
      'retry': 'Try again',
      'comingSoon': 'Coming soon',
      'cat.declaracao.name': 'Love Declarations',
      'cat.declaracao.desc': 'Say what your heart feels',
      'cat.te_amo.name': 'I Love You',
      'cat.te_amo.desc': 'Three words, a thousand feelings',
      'cat.bomdia.name': 'Good Morning, Love',
      'cat.bomdia.desc': 'Start the day with tenderness',
      'cat.boanoite.name': 'Good Night, Love',
      'cat.boanoite.desc': 'Fall asleep thinking of me',
      'cat.saudade.name': 'Missing You',
      'cat.saudade.desc': 'When distance aches',
      'cat.paixao.name': 'Passion',
      'cat.paixao.desc': 'The fire that burns for you',
      'cat.namoro.name': 'Relationship',
      'cat.namoro.desc': 'Everyday love',
      'cat.distancia.name': 'Long Distance',
      'cat.distancia.desc': 'Close at heart',
      'cat.reconciliacao.name': 'Making Up',
      'cat.reconciliacao.desc': 'A sincere apology',
      'cat.casamento.name': 'Forever',
      'cat.casamento.desc': 'A love without end',
      'cat.cantadas.name': 'Flirty Lines',
      'cat.cantadas.desc': 'To spark a smile',
      'cat.gratidao.name': 'Grateful for You',
      'cat.gratidao.desc': 'Thank you for being you',
      'nav.couple': 'Us',
      'couple.tagline': 'All about your love',
      'couple.nameLabel': "Your love's name",
      'couple.dateLabel': 'We started dating on',
      'couple.tapToSet': 'Tap to set',
      'couple.daysWord': 'days together',
      'couple.noDate': 'Set the day you started to see your days together.',
      'couple.nextMonthsary': '{n} days to your monthly anniversary 💞',
      'couple.nextAnniversary': '{n} days to your dating anniversary 🎉',
      'couple.todaySpecial': 'Today is your special day! 🎉',
      'card.generator': 'Message generator',
      'card.generatorDesc': 'Create a unique message',
      'card.questions': 'Questions for couples',
      'card.questionsDesc': 'Grow closer by talking',
      'card.challenge': '30-day challenge',
      'card.challengeDesc': 'One act of love a day',
      'dlg.save': 'Save',
      'dlg.clear': 'Clear',
      'name.hint': 'e.g. Sarah',
      'gen.title': 'Message generator',
      'gen.chooseTone': 'Choose the tone',
      'gen.personalized': 'Personalized for {name}',
      'gen.setNameHint': "Set your love's name to personalize",
      'gen.generate': 'Generate message',
      'gen.regenerate': 'Generate another',
      'gen.empty': 'Choose a tone and tap Generate.',
      'tone.romantico': 'Romantic',
      'tone.fofo': 'Sweet / Good morning',
      'tone.saudade': 'Missing you',
      'tone.desculpas': 'Sorry',
      'tone.engracado': 'Funny',
      'tone.compromisso': 'Commitment',
      'tone.gratidao': 'Gratitude',
      'q.title': 'Questions for couples',
      'q.intro': 'A question to bring you closer',
      'q.next': 'Next question',
      'ch.title': '30 days of love challenge',
      'ch.dayWord': 'Day',
      'ch.progress': '{n}/30 done',
      'ch.markDone': 'Mark as done',
      'ch.doneWord': 'Done',
      'ch.comeTomorrow': 'Come back tomorrow for the next one 💞',
      'ch.complete': 'You finished the 30 days of love! 💞',
      'ch.locked': 'Finish the previous day first',
      'card.letters': 'Scheduled letters',
      'card.lettersDesc': 'Messages that open on a date',
      'letters.title': 'Scheduled letters',
      'letters.empty': 'Write a letter that only opens on the date you choose. 💌',
      'letters.new': 'New letter',
      'letters.writeHint': 'Write your love message...',
      'letters.revealLabel': 'Open on',
      'letters.lockedIn': 'Opens in {n} days 🔒',
      'letters.opensToday': 'Opens today! 💌',
      'letters.sealed': 'Sealed letter',
      'letters.save': 'Save letter',
      'letters.needFuture': 'Pick a future date.',
      'letters.delete': 'Delete',
      'care.label': 'Care reminder',
      'care.desc': 'A little daily nudge to send love',
      'care.notifBody': 'How about sending some love right now? 💕',
      'care.whatsapp': 'Send on WhatsApp',
      'widget.daysLabel': 'days together',
      'card.animated': 'Animated card',
      'card.animatedDesc': 'A moving story card 💞',
      'anim.export': 'Save GIF and share',
      'anim.exporting': 'Creating your GIF...',
      'anim.done': 'GIF saved to gallery! 💞',

    },
    'es': {
      'app.name': 'Mensajes de Amor',
      'app.subtitle': 'Mensajes de amor para cada día.',
      'notifications': 'Notificaciones',
      'verseOfDay': 'FRASE DEL DÍA',
      'dailyInspiration': 'Inspiración diaria',
      'share': 'Compartir',
      'save': 'Guardar',
      'newVerse': 'Nueva frase',
      'savedToFavorites': 'Guardado en favoritos',
      'removedFromFavorites': 'Quitado de favoritos',
      'exploreByCategory': 'Explora por categoría',
      'seeAll': 'Ver todas',
      'moreInspirations': 'Más inspiraciones',
      'navHome': 'Inicio',
      'navExplore': 'Explorar',
      'navFavorites': 'Favoritos',
      'navSettings': 'Ajustes',
      'navCategories': 'Categorías',
      'navMore': 'Más',
      'categoriesTitle': 'Categorías',
      'filterAll': 'Todas',
      'filterPopular': 'Más populares',
      'filterNew': 'Nuevas',
      'verse.one': 'frase',
      'verse.many': 'frases',
      'notifBody': 'Toca para ver tu frase de hoy 🌅',
      'removeAdsTitle': 'Quitar anuncios',
      'removeAdsHero': 'Usa la app sin anuncios',
      'removeAdsDesc': 'Pago único, para siempre. Sin suscripciones.',
      'removeAdsCta': 'Quitar anuncios',
      'adsRemovedTitle': '¡Ya quitaste los anuncios!',
      'adsRemovedDesc': 'Gracias por tu apoyo 🙏 Disfruta sin interrupciones.',
      'watchVideoAdFree': 'Ver un video (24h sin anuncios)',
      'restorePurchase': 'Restaurar compra',
      'processing': 'Procesando…',
      'purchaseSuccess': '¡Listo! Anuncios quitados. 🎉',
      'purchaseFailed': 'No se pudo completar la compra.',
      'adFreeFor24h': '¡Sin anuncios por 24 horas! ✨',
      'freeBenefitsTitle': 'TODO ESTO ES GRATIS',
      'benefitThemes': 'Tema claro y oscuro',
      'benefitEditor': 'Editor de imagen con filtros',
      'benefitContent': 'Todas las categorías y frases',
      'benefitOffline': 'Funciona sin conexión, en tu idioma',
      'copy': 'Copiar',
      'copied': 'Frase copiada',
      'favorite': 'Favorito',
      'createImage': 'Crear imagen',
      'editImage': 'Editar',
      'shareImage': 'Compartir imagen',
      'savedToGallery': 'Imagen guardada en la galería',
      'saveError': 'No se pudo guardar la imagen',
      'backgroundsLabel': 'Fondo',
      'filtersLabel': 'Filtros',
      'adjustmentsLabel': 'Ajustes',
      'textLabel': 'Texto',
      'brightness': 'Brillo',
      'contrast': 'Contraste',
      'saturation': 'Saturación',
      'intensity': 'Intensidad',
      'textSize': 'Tamaño',
      'textColor': 'Color',
      'alignment': 'Alineación',
      'reset': 'Restablecer',
      'undo': 'Deshacer',
      'redo': 'Rehacer',
      'fmtStory': 'Story',
      'fmtFeed': 'Feed',
      'fmtStatus': 'Status',
      'filterNone': 'Original',
      'filterBlue': 'Frío',
      'filterYellow': 'Cálido',
      'filterRed': 'Atardecer',
      'filterVintage': 'Vintage',
      'filterBW': 'B/N',
      'filterWarm': 'Cálido',
      'filterNoir': 'Noir',
      'filterFade': 'Desvaído',
      'filterDrama': 'Drama',
      'filterMint': 'Menta',
      'filterPurple': 'Púrpura',
      'bgPhotos': 'Fotos',
      'bgColors': 'Colores',
      'bgGradients': 'Degradados',
      'bgTextures': 'Texturas',
      'texNone': 'Ninguna',
      'texGrain': 'Grano',
      'texDots': 'Puntos',
      'texLines': 'Líneas',
      'texBokeh': 'Bokeh',
      'texGlow': 'Brillo',
      'texVignette': 'Viñeta',
      'favoritesTitle': 'Favoritos',
      'favText': 'Texto',
      'favByCategory': 'Por categoría',
      'emptyFavorites': 'Aún no has guardado ninguna frase.',
      'emptyFavoritesHint': 'Toca el corazón para guardar las que más te gusten.',
      'searchTitle': 'Buscar',
      'searchHint': 'Escribe una palabra clave...',
      'popularSuggestions': 'Sugerencias populares',
      'results': 'Resultados',
      'searchPrompt': 'Busca por tema, palabra o categoría.',
      'noResults': 'Sin resultados para "{q}".',
      'settingsTitle': 'Ajustes',
      'language': 'Idioma',
      'systemDefault': 'Predeterminado del sistema',
      'notificationsLabel': 'Notificaciones',
      'notificationsDesc': 'Recibe una inspiración cada día',
      'theme': 'Tema',
      'themeSystem': 'Automático',
      'themeLight': 'Claro',
      'themeDark': 'Oscuro',
      'fontSize': 'Tamaño de fuente',
      'fontSmall': 'Pequeño',
      'fontDefault': 'Normal',
      'fontLarge': 'Grande',
      'about': 'Acerca de',
      'shareApp': 'Compartir app',
      'rateApp': 'Valorar en Play Store',
      'privacy': 'Política de Privacidad',
      'terms': 'Términos de Uso',
      'privacyBody':
          'Respetamos tu privacidad. Esta aplicación funciona totalmente sin '
              'conexión y NO recopila, almacena ni comparte datos personales.\n\n'
              '• Las preferencias y favoritos se guardan solo en tu '
              'dispositivo.\n'
              '• No exigimos registro, inicio de sesión ni acceso a tu '
              'ubicación, contactos o archivos.\n'
              '• Podemos mostrar anuncios de Google AdMob. AdMob puede usar '
              'identificadores del dispositivo para mostrar anuncios; consulta '
              'la política de Google en policies.google.com/privacy. Puedes '
              'quitar los anuncios con la compra dentro de la app.\n'
              '• Las imágenes que creas se guardan solo donde elijas '
              'compartirlas o guardarlas.\n\n'
              'Para dudas sobre privacidad, escríbenos al correo de soporte '
              'indicado en la Play Store.',
      'termsBody':
          'Al usar esta aplicación, aceptas estos términos.\n\n'
              '• La app se ofrece "tal cual", para uso personal y no '
              'comercial, con fines de inspiración y entretenimiento.\n'
              '• Las frases e imágenes pueden compartirse libremente para uso '
              'personal; no las revendas como un producto competidor.\n'
              '• No nos responsabilizamos por decisiones tomadas con base en el '
              'contenido mostrado.\n'
              '• Podemos actualizar funciones, contenido y estos términos en '
              'cualquier momento, con la nueva versión publicada en la Play '
              'Store.\n\n'
              'Si no estás de acuerdo con los términos, desinstala la '
              'aplicación.',
      'version': 'Versión',
      'preferences': 'PREFERENCIAS',
      'general': 'GENERAL',
      'onbSubtitle': 'Mensajes de amor para calentar el corazón cada día.',
      'onbSub2': 'Guarda tus favoritas y envíalas a quien amas.',
      'onbSub3': 'Crea imágenes hermosas y comparte tu amor — sin conexión.',
      'skip': 'Saltar',
      'start': 'Empezar',
      'next': 'Siguiente',
      'loading': 'Cargando...',
      'emptyVerses': 'Aún no hay frases disponibles.',
      'errorLoading': 'No se pudo cargar el contenido.',
      'retry': 'Reintentar',
      'comingSoon': 'Próximamente',
      'cat.declaracao.name': 'Declaraciones de Amor',
      'cat.declaracao.desc': 'Di lo que siente el corazón',
      'cat.te_amo.name': 'Te Amo',
      'cat.te_amo.desc': 'Dos palabras, mil sentimientos',
      'cat.bomdia.name': 'Buenos Días, Amor',
      'cat.bomdia.desc': 'Empieza el día con cariño',
      'cat.boanoite.name': 'Buenas Noches, Amor',
      'cat.boanoite.desc': 'Duerme pensando en mí',
      'cat.saudade.name': 'Te Extraño',
      'cat.saudade.desc': 'Cuando la distancia aprieta',
      'cat.paixao.name': 'Pasión',
      'cat.paixao.desc': 'El fuego que arde por ti',
      'cat.namoro.name': 'Noviazgo',
      'cat.namoro.desc': 'El amor de cada día',
      'cat.distancia.name': 'Amor a Distancia',
      'cat.distancia.desc': 'Cerca en el corazón',
      'cat.reconciliacao.name': 'Reconciliación',
      'cat.reconciliacao.desc': 'Una disculpa sincera',
      'cat.casamento.name': 'Para Siempre',
      'cat.casamento.desc': 'Un amor sin fin',
      'cat.cantadas.name': 'Piropos',
      'cat.cantadas.desc': 'Para arrancar una sonrisa',
      'cat.gratidao.name': 'Gratitud por tu Amor',
      'cat.gratidao.desc': 'Gracias por ser tú',
      'nav.couple': 'Nosotros',
      'couple.tagline': 'Todo sobre el amor de ustedes',
      'couple.nameLabel': 'Nombre de tu amor',
      'couple.dateLabel': 'Empezamos a salir el',
      'couple.tapToSet': 'Toca para definir',
      'couple.daysWord': 'días juntos',
      'couple.noDate': 'Define el día en que empezaron para ver sus días juntos.',
      'couple.nextMonthsary': 'Faltan {n} días para su aniversario del mes 💞',
      'couple.nextAnniversary': 'Faltan {n} días para su aniversario de novios 🎉',
      'couple.todaySpecial': '¡Hoy es un día especial de ustedes! 🎉',
      'card.generator': 'Generador de mensajes',
      'card.generatorDesc': 'Crea un mensaje único',
      'card.questions': 'Preguntas para la pareja',
      'card.questionsDesc': 'Acérquense conversando',
      'card.challenge': 'Reto de 30 días',
      'card.challengeDesc': 'Un gesto de amor por día',
      'dlg.save': 'Guardar',
      'dlg.clear': 'Borrar',
      'name.hint': 'Ej.: María',
      'gen.title': 'Generador de mensajes',
      'gen.chooseTone': 'Elige el tono',
      'gen.personalized': 'Personalizado para {name}',
      'gen.setNameHint': 'Define el nombre de tu amor para personalizar',
      'gen.generate': 'Generar mensaje',
      'gen.regenerate': 'Generar otro',
      'gen.empty': 'Elige un tono y toca Generar.',
      'tone.romantico': 'Romántico',
      'tone.fofo': 'Tierno / Buenos días',
      'tone.saudade': 'Te extraño',
      'tone.desculpas': 'Disculpas',
      'tone.engracado': 'Divertido',
      'tone.compromisso': 'Compromiso',
      'tone.gratidao': 'Gratitud',
      'q.title': 'Preguntas para la pareja',
      'q.intro': 'Una pregunta para acercarlos',
      'q.next': 'Siguiente pregunta',
      'ch.title': 'Reto de 30 días de amor',
      'ch.dayWord': 'Día',
      'ch.progress': '{n}/30 completados',
      'ch.markDone': 'Marcar como hecho',
      'ch.doneWord': 'Hecho',
      'ch.comeTomorrow': 'Vuelve mañana para el siguiente 💞',
      'ch.complete': '¡Completaron los 30 días de amor! 💞',
      'ch.locked': 'Completa el día anterior primero',
      'card.letters': 'Cartas programadas',
      'card.lettersDesc': 'Mensajes que se abren en una fecha',
      'letters.title': 'Cartas programadas',
      'letters.empty': 'Escribe una carta que solo se abrirá en la fecha que elijas. 💌',
      'letters.new': 'Nueva carta',
      'letters.writeHint': 'Escribe tu mensaje de amor...',
      'letters.revealLabel': 'Abrir el',
      'letters.lockedIn': 'Se abre en {n} días 🔒',
      'letters.opensToday': '¡Se abre hoy! 💌',
      'letters.sealed': 'Carta sellada',
      'letters.save': 'Guardar carta',
      'letters.needFuture': 'Elige una fecha futura.',
      'letters.delete': 'Borrar',
      'care.label': 'Recordatorio de cariño',
      'care.desc': 'Un pequeño empujón diario para enviar amor',
      'care.notifBody': '¿Qué tal enviar un poco de amor ahora? 💕',
      'care.whatsapp': 'Enviar por WhatsApp',
      'widget.daysLabel': 'días juntos',
      'card.animated': 'Tarjeta animada',
      'card.animatedDesc': 'Una historia con movimiento 💞',
      'anim.export': 'Guardar GIF y compartir',
      'anim.exporting': 'Creando tu GIF...',
      'anim.done': '¡GIF guardado en la galería! 💞',

    },
  };

  /// Os 64 idiomas-alvo da publicação. A UI aceita todos; os que ainda não
  /// têm mapa em [_data] caem no inglês automaticamente (sem quebrar layout).
  /// Idiomas REALMENTE traduzidos (UI + conteúdo). O seletor de idioma só
  /// oferece estes; [targetLanguages] fica como alvo de expansão futura.
  static const List<String> uiLanguages = ['pt', 'en', 'es'];

  static const List<String> targetLanguages = [
    'pt', 'en', 'es', 'fr', 'de', 'it', 'nl', 'pl', 'ru', 'uk', 'tr', 'ar',
    'fa', 'he', 'hi', 'bn', 'ur', 'ta', 'te', 'mr', 'gu', 'kn', 'ml', 'pa',
    'id', 'ms', 'th', 'vi', 'fil', 'ja', 'ko', 'zh', 'zh_TW', 'my', 'km',
    'si', 'ne', 'sw', 'am', 'ha', 'yo', 'zu', 'af', 'sq', 'az', 'be', 'bg',
    'hr', 'cs', 'da', 'et', 'fi', 'el', 'hu', 'is', 'ka', 'kk', 'lv', 'lt',
    'ro', 'sr', 'sk', 'sl', 'sv',
  ];

  static List<Locale> get supportedLocales => [
        for (final code in targetLanguages)
          code.contains('_')
              ? Locale(code.split('_')[0], code.split('_')[1])
              : Locale(code),
      ];

  /// Resolve o locale do aparelho para um dos suportados (fallback inglês).
  static Locale resolve(Locale? device, Iterable<Locale> supported) {
    if (device == null) return const Locale('en');
    for (final l in supported) {
      if (l.languageCode == device.languageCode) return l;
    }
    return const Locale('en');
  }
}

/// Delegate que injeta [T] na árvore via Localizations.
class TDelegate extends LocalizationsDelegate<T> {
  const TDelegate();

  @override
  bool isSupported(Locale locale) =>
      T.targetLanguages.any((c) => c.split('_')[0] == locale.languageCode);

  @override
  Future<T> load(Locale locale) async => T(locale);

  @override
  bool shouldReload(TDelegate old) => false;
}
