import 'package:in_a_bottle/adapters/injection/injector_module.dart';
import 'package:in_a_bottle/adapters/injection/get_it_injector.dart';


///Uset to abstract injection dependency lib.
abstract class BaseInjector {
  ///Singleton instance of [BaseInjector]
  factory BaseInjector() {
    //injector used by default.
    return GetItInjector();
  }

  T get<T extends Object>(
      {String key, Map<String, dynamic>? additionalParameters});

  void register<S extends Object, T extends S>(InjectorFactory<S> _factory,
      {bool isSingleton = false, String? key});
}

extension Initilizer on BaseInjector {
  void initialiseAll(Iterable<InjectorModule> modules) {
    modules.forEach((m) => m.initialise(this));
  }
}

///The builder of injector.
// ignore: prefer_generic_function_type_aliases
typedef T InjectorFactory<T>(BaseInjector injector);
