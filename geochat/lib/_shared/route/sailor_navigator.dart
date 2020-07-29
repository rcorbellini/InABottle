import 'package:geochat/_shared/route/navigator.dart';
import 'package:sailor/sailor.dart';

final Sailor sailor = Sailor();

class SailorNavigator extends Navigator {
  @override
  Future<T> navigateTo<T>(String route, {Map<String, dynamic> params}) {
    return sailor.navigate<T>(route, params: params);
  }

  @override
  void pop() {
    sailor.navigatorKey.currentState.pop();
  }
}
