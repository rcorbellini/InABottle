import 'package:in_a_bottle/_shared/injection/injector.dart' as injector_interface;
import 'package:flutter_simple_dependency_injection/injector.dart';

class SimpleInjector implements injector_interface.Injector {
  static final SimpleInjector _singleton = SimpleInjector._internal();

  factory SimpleInjector() {
    return _singleton;
  }
  
  SimpleInjector._internal();

  @override
  T get<T>({String key, Map<String, dynamic> additionalParameters}) =>
      Injector.getInjector()
          .get<T>(key: key, additionalParameters: additionalParameters);

  @override
  Iterable<T> getAll<T>({Map<String, dynamic> additionalParameters}) =>
      Injector.getInjector()
          .getAll<T>(additionalParameters: additionalParameters);

  @override
  void register<S, T extends S>(injector_interface.InjectorFactory<S> _factory,
      {bool isSingleton = false, String key}) {
    Injector.getInjector()
        .map<S>((_) => _factory(this), key: key, isSingleton: isSingleton);
  }

  @override
  void unregister<T>({String key}) {
    throw Exception("Not implemented");
  }
}
