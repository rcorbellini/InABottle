import 'dart:convert';
import 'package:flutter/services.dart';
import "package:yaml/yaml.dart";

mixin MapFromFileJson {
  ///Obtem o Map que esta definido no [fileJsonPath]
  ///e retorna, caso não encontre retorna um map vazio.
  ///
  ///O Path precisa ser de um arquivo previamente mapeado via
  ///pubspec.yaml
  Future<Map<String, String>> mapFromJson(String fileJsonPath) async {
    try {
      String jsonString = await rootBundle.loadString(fileJsonPath);

      Map<String, dynamic> jsonMap =
          json.decode(jsonString) as Map<String, dynamic>;

      return jsonMap.map((k, Object v) => MapEntry(k, v.toString()));
    } on Exception catch (_) {
      //se não encontrou o arquivo de strings retorna map vazio.
      return {};
    }
  }
}

mixin MapFromFileYaml {
  ///Obtem o Map que esta definido no [fileYamlPath]
  ///e retorna, caso não encontre retorna um map vazio.
  ///
  ///O Path precisa ser de um arquivo previamente mapeado via
  ///pubspec.yaml
  Future<dynamic> mapFromYaml(String fileYamlPath) async {
    try {
      String yamlString = await rootBundle.loadString(fileYamlPath);

      final dynamic yamlMap = loadYaml(yamlString);

      return yamlMap;
    } on Exception{
      //se não encontrou o arquivo de strings retorna map vazio.
      return <dynamic, dynamic>{};
    }
  }

  /// irá obter o valor de um map de yaml
  /// de forma recursiva, navegando pelo splitter definido.
  dynamic getYamlValue(String key, dynamic map, {String splitter = "."}) {
    if (key == null || map == null) {
      return null;
    }
    if (!key.contains(splitter)) {
      return map[key];
    }
    final indexSplitter = key.indexOf(splitter); 
    final currentKey = key.substring(0, indexSplitter);
    final nextKey = key.substring(indexSplitter + 1);
    final dynamic nextMap = map[currentKey];
    return getYamlValue(nextKey, nextMap);
  }
}
