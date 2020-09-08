import 'package:flutter/material.dart';

abstract class Navigator {
  Future<T> navigateTo<T>(String route, {Map<String, dynamic> params});

  void pop<T>([T result]);

  RouteFactory buildRouteFactory();

  GlobalKey<NavigatorState> get navigatorKey;
}
