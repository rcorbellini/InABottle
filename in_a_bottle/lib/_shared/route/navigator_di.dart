import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/_shared/injection/injector_module.dart';
import 'package:in_a_bottle/_shared/route/heimdall.dart';
import 'package:in_a_bottle/_shared/route/navigator.dart';

class NavigatorDI implements InjectorModule {
  @override
  void initialise(Injector injector) {
    injector.register<Navigator, Heimdall>((i) => Heimdall());
  }
}
