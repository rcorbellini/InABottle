import 'package:geochat/_shared/injection/simple_injector.dart';

abstract class Injector {
  factory Injector() {
    //injector used by system.
    return SimpleInjector();
  }

  T get<T>({String key, Map<String, dynamic> additionalParameters});

  Iterable<T> getAll<T>({Map<String, dynamic> additionalParameters});

  void unregister<T>({String key});

  void register<S, T extends S>(InjectorFactory<S> _factory,
      {bool isSingleton = false, String key});
}

typedef T InjectorFactory<T>(Injector injector);
