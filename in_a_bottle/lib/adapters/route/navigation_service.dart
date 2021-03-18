import 'package:flutter/material.dart';

abstract class NavigationService {
  GlobalKey<NavigatorState> get navigatorKey;

  void pop();

  void navigate(String route, {Object? parameter, bool? replace});
}

class NavigationServiceImp extends NavigationService {
  NavigationServiceImp._();

  static final NavigationServiceImp _instance = NavigationServiceImp._();

  factory NavigationServiceImp() => _instance;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => navigatorKey.currentState;

  @override
  void pop() {
    _navigator?.pop();
  }

  @override
  void navigate(String route, {Object? parameter, bool? replace}) {
    if (replace ?? false) {
      _navigator?.pushReplacementNamed(route, arguments: parameter);
    } else {
      _navigator?.pushNamed(route, arguments: parameter);
    }
  }
}