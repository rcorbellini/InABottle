import 'package:geochat/_shared/injection/injector.dart';
import 'package:geochat/_shared/injection/injector_module.dart';
import 'package:geochat/_shared/route/navigator.dart';
import 'package:geochat/_shared/route/sailor_navigator.dart';

class NavigatorDI implements InjectorModule {
  @override
  void initialise(Injector injector) {
    injector.register<Navigator, SailorNavigator>((i) => SailorNavigator());
  }
}
