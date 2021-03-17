import 'package:get_it/get_it.dart';
import 'package:in_a_bottle/adapters/injection/base_injector.dart';

class GetItInjector implements BaseInjector {
  GetItInjector._internal();

  ///The instance of Get It implementation (singleton)
  factory GetItInjector() {
    return _singleton;
  }

  static final GetItInjector _singleton = GetItInjector._internal();

  @override
  T get<T extends Object>(
      {String? key, Map<String, dynamic>? additionalParameters}) {
    return GetIt.instance<T>(instanceName: key);
  }

  @override
  void register<S extends Object, T extends S>(_factory,
      {bool isSingleton = false, String? key}) {
    if (isSingleton) {
      GetIt.instance.registerSingleton<S>(_factory(this), instanceName: key);
    } else {
      GetIt.instance
          .registerFactory<S>(() => _factory(this), instanceName: key);
    }
  }
}

class InjectorException implements Exception {}
