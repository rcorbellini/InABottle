import 'dart:convert';

import 'package:in_a_bottle/_shared/datastorage/key_value_storage.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceStorage extends KeyValueStorage {
  final Future<SharedPreferences> _futPrefs = SharedPreferences.getInstance();

  @override
  Future<void> setValue<T>(String key, T value) async {
    final pref = await _futPrefs;

    //Tratando null
    if (value == null) {
      await pref.setString(key, null);
      return;
    }

    //tratando as opções suportada pelo shared
    if (value is String) {
      await pref.setString(key, value);
    } else if (value is int) {
      await pref.setInt(key, value);
    } else if (value is bool) {
      await pref.setBool(key, value);
    } else if (value is double) {
      await pref.setDouble(key, value);
    } else if (value is List<String>) {
      await pref.setStringList(key, value);
    } else if (value is Map) {
      await pref.setString(key, jsonEncode(value));
    }
  }

  @override
  Future<T> getValue<T>(String key) async {
    final pref = await _futPrefs;

    final dynamic value = pref.get(key);

    if (value is String && value.contains("{") && value.contains("}")) {
      try {
        //tentando converter o map
        final T map = jsonDecode(value) as T;
      } on Exception {
        print("Expected a Map but don't, will return as raw");
      }
    }

    return value as T;
  }
}
