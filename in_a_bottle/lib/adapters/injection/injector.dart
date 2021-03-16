import 'package:in_a_bottle/adapters/injection/injector_module.dart';
import 'package:in_a_bottle/adapters/injection/simple_injector.dart';

abstract class Injector {
  factory Injector() {
    //injector used by system.
    return GetItInjector();
  }

  T get<T>({String key, Map<String, dynamic>? additionalParameters});

  void register<S extends Object, T extends S>(InjectorFactory<S> _factory,
      {bool isSingleton = false, String? key});
}

extension Initilizer on Injector {
  void initialiseAll(Iterable<InjectorModule> modules) {
    modules.forEach((m) => m.initialise(this));
  }
}

typedef T InjectorFactory<T>(Injector injector);
