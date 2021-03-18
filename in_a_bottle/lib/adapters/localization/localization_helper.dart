import 'package:flutter/material.dart';
import 'package:in_a_bottle/adapters/file_readers/yaml.dart';

///Este é o helperer usado pelo Delegate [ChamaleonLocalizationsDelegate]
/// pra carregar as strings e disponibilizar elas pros widgets através de
/// [LocalizationsYamlHelper.of(context)]
class LocalizationsYamlHelper with MapFromFileYaml {
  //locale no qual esta sendo carregado.
  final Locale currentLocale;

  LocalizationsYamlHelper(this.currentLocale);

  static LocalizationsYamlHelper of(BuildContext context) {
    return Localizations.of(context, LocalizationsYamlHelper);
  }

  ///Map da representacao do JSON atual das strings.
  dynamic _localizedStringsMain;

  ///
  ///Irá carregar no [_localizedStrings] os texto necessários;
  Future<bool> init() async {
    //primeiro carrega as strings padrao do sistema, na lingua definida
    //pelo dispositivo
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
  String translate(String key) {
    String? text = getYamlValue(key, _localizedStringsMain)?.toString();

    assert(text != null,
        "The $key is not present in ${currentLocale.languageCode}.yaml ");

    return text ?? '';
  }
}
