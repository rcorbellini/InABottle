import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/localization/from_file.dart';
import 'package:in_a_bottle/_shared/localization/translation_helper.dart';

///Este é o helperer usado pelo Delegate [AppLocalizationsDelegate]
/// pra carregar as strings e disponibilizar elas pros widgets através de
/// [AppLocalizations.of(context)],
/// ou para os Blocs através do [TranslationHelper]
class AppLocalizations with MapFromFileYaml implements TranslationHelper {
  //locale no qual esta sendo carregado.
  final Locale currentLocale;

  AppLocalizations(this.currentLocale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of(context, AppLocalizations);
  }

  ///Map da representacao do JSON atual (baseado no client + idioma)
  dynamic _localizedStringsMain;

  ///
  ///Irá carregar no [_localizedStrings] os texto necessários, de acordo com
  ///o [clientPrefix] passado de parametro idioma informado ao SO.
  ///
  Future<bool> init() async {
    _localizedStringsMain =
        await mapFromYaml('lang/${currentLocale.languageCode}.yaml');
    return true;
  }

  void clear() {
    _localizedStringsMain = null;
  }

  ///obtem o texto traduzido e retorna.
  ///é obrigado a ter o texto que esta sendo solicitado via chave
  ///caso não exista irá gerar um erro (assertiva)
  @override
  String translate(String key) {
    String text = getYamlValue(key, _localizedStringsMain) as String;

    assert(text != null,
        "The $key is not present in ${currentLocale.languageCode}.yaml ");

    return text;
  }
}

///Esse é o delegate usado pra configurar no MaterialApp os localization
///do sistema.
///
///Ele tem como objetivo suportar tanto localization quanto
///a troca de textos em clientes.
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  ///pra informar quais os locales são permitidos no app,
  ///caso definir um idioma não suportado será adotado a regra definida no
  ///widget [MaterialApp.localeResolutionCallback] normalmente localizado
  ///na classe main da aplicação, existe a [localeResolutionCallback] neste
  ///arquivo que é indicado como sendo a estrategia default para resolver
  ///idiomas não encontrado
  final Iterable<Locale> supportedLocales;

  const AppLocalizationsDelegate({@required this.supportedLocales});

  @override
  bool isSupported(Locale locale) => supportedLocales
      .any((supLocale) => supLocale.languageCode == locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.init();
    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}

///Estrategia padrao para definir um locale.
///Caso não encontre um locale irá definir o primeiro da lista
///como sendo o locale atual
Locale localeResolutionCallback(
    Locale local, Iterable<Locale> supportedLocales) {
  for (final supportedLocale in supportedLocales) {
    if (local != null &&
        supportedLocale.languageCode == local.languageCode &&
        supportedLocale.countryCode == local.countryCode) {
      return supportedLocale;
    }
  }

  //por padrao retorna o primeiro locale suportado.
  return supportedLocales.first;
}
