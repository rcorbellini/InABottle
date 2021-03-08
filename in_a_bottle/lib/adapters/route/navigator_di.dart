import 'package:in_a_bottle/adapters/injection/injector.dart';
import 'package:in_a_bottle/adapters/injection/injector_module.dart';
import 'package:in_a_bottle/adapters/route/heimdall.dart';
import 'package:in_a_bottle/adapters/route/navigator.dart';

class NavigatorDI implements InjectorModule {
  @override
  void initialise(Injector injector) {
    injector.register<Navigator, Heimdall>((i) => Heimdall());
  }
}
