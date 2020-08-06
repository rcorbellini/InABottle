import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/_shared/injection/injector_module.dart';
import 'package:in_a_bottle/_shared/route/navigator.dart';
import 'package:in_a_bottle/_shared/route/sailor_navigator.dart';

class NavigatorDI implements InjectorModule {
  @override
  void initialise(Injector injector) {
    injector.register<Navigator, SailorNavigator>((i) => SailorNavigator());
  }
}
