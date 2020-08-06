import 'package:flutter/material.dart';
import 'package:geochat/_shared/route/navigator.dart' as interface_navigator;
import 'package:sailor/sailor.dart';

final Sailor sailor = Sailor();

class SailorNavigator extends interface_navigator.Navigator {
  @override
  Future<T> navigateTo<T>(String route, {Map<String, dynamic> params}) {
    return sailor.navigate<T>(route, params: params);
  }

  @override
  void pop() {
    sailor.navigatorKey.currentState.pop();
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => sailor.navigatorKey;

  @override
  RouteFactory buildRouteFactory() => sailor.generator();
}
