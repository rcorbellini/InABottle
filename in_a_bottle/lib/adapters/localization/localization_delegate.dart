import 'package:flutter/material.dart';
import 'package:in_a_bottle/adapters/localization/localization_helper.dart';

///Esse é o delegate usado pra configurar no MaterialApp os localization
///do sistema.
///
///Ele tem como objetivo suportar tanto localization quanto
///a troca de textos em flavores.
class LocalizationsYamlDelegate
    extends LocalizationsDelegate<LocalizationsYamlHelper> {
  ///pra informar quais os locales são permitidos no app,
  ///caso definir um idioma não suportado será adotado a regra definida no
  ///widget [MaterialApp.localeResolutionCallback]
  final Iterable<Locale> supportedLocales;

  const LocalizationsYamlDelegate({required this.supportedLocales});

  @override
  bool isSupported(Locale locale) => supportedLocales
      .any((supLocale) => supLocale.languageCode == locale.languageCode);

  @override
  Future<LocalizationsYamlHelper> load(Locale locale) async {
    LocalizationsYamlHelper localizations = LocalizationsYamlHelper(locale);
    await localizations.init();
    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<LocalizationsYamlHelper> old) =>
      false;
}
