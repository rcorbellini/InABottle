import 'package:get_it/get_it.dart';
import 'package:in_a_bottle/adapters/injection/injector.dart'
    as injector_interface;

class GetItInjector implements injector_interface.Injector {
  static final GetItInjector _singleton = GetItInjector._internal();

  factory GetItInjector() {
    return _singleton;
  }

  GetItInjector._internal();

  final GetIt _instance = GetIt.asNewInstance();

  @override
  T get<T>({String? key, Map<String, dynamic>? additionalParameters}) {
    try {
      return _instance<T>(instanceName: key);
    } on AssertionError {
      throw InjectorException();
    }
  }

  @override
  void register<S extends Object, T extends S>(injector_interface.InjectorFactory<S> _factory,
      {bool isSingleton = false, String? key}) {
    if (isSingleton) {
      _instance.registerSingleton<S>(_factory(this), instanceName: key);
    } else {
      _instance.registerFactory<S>(() => _factory(this), instanceName: key);
    }
  }

}

class InjectorException implements Exception {}
