import 'package:flutter/material.dart';

///Estrategia padrao para definir um locale.
///Caso não encontre um locale irá definir o primeiro da lista
///como sendo o locale atual

Locale? localeResolutionCallback(
    Locale? locale, Iterable<Locale> supportedLocales) {
  for (final supportedLocale in supportedLocales) {
    if (locale != null &&
        supportedLocale.languageCode == locale.languageCode &&
        supportedLocale.countryCode == locale.countryCode) {
      return supportedLocale;
    }
  }

  //por padrao retorna o primeiro locale suportado.
  return supportedLocales.first;
}
