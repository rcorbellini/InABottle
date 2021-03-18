import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

mixin MapFromFileYaml {
  ///Obtem o Map que esta definido no [fileYamlPath]
  ///e retorna, caso não encontre retorna um map vazio.
  ///
  ///O Path precisa ser de um arquivo previamente mapeado via
  ///pubspec.yaml
  Future<dynamic> mapFromYaml(String fileYamlPath) async {
    try {
      String yamlString = await rootBundle.loadString(fileYamlPath);

      final yamlMap = loadYaml(yamlString);

      return yamlMap;
    } on Error catch (_) {
      //se não encontrou o arquivo de strings retorna map vazio.
      return {};
    }
  }

  /// irá obter o valor de um map de yaml
  /// de forma recursiva, navegando pelo splitter definido.
  Object? getYamlValue(String? key, dynamic? map, {String splitter = "."}) {
    if (key == null || map == null) {
      return null;
    }
    if (!key.contains(splitter)) {
      return map[key];
    }
    final indexSplitter = key.indexOf(splitter); 
    final currentKey = key.substring(0, indexSplitter);
    final nextKey = key.substring(indexSplitter + 1);
    final nextMap = map[currentKey];
    return getYamlValue(nextKey, nextMap);
  }
}
