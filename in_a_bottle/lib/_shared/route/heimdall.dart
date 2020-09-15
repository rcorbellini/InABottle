import 'dart:async';

import 'package:flutter/src/widgets/navigator.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:heimdall/heimdall.dart';
import 'package:in_a_bottle/_shared/route/navigator.dart' as nav;
import 'package:fancy_stream/fancy_stream.dart';

class Heimdall implements nav.Navigator {
  @override
  buildRouteFactory() {
    // TODO: implement buildRouteFactory
    throw UnimplementedError();
  }

  @override
  Future<T> navigateTo<T>(String route, {Map<String, dynamic> params}) async {
    Completer<T> completer = Completer<T>();
    DispatchRouter().dispatchOn<SysRoute>(SysRoute(
        routeForward: RouteForward<T>(route,
            routeParameter: params, onComplete: completer.complete)));

    return completer.future;
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => DispatchRouter().navigatorKey;

  @override
  void pop<T>([T result]) {
    DispatchRouter().dispatchOn<SysRoute>(SysRoute.pop(result));
  }
}
