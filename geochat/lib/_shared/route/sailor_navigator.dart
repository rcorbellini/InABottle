import 'package:geochat/_shared/route/navigator.dart';
import 'package:geochat/home/home_bloc.dart';
import 'package:geochat/home/home_widget.dart';
import 'package:sailor/sailor.dart';

final sailor = Sailor();

class SailorNavigator extends Navigator {
  @override
  Future<T> navigateTo<T>(String route, {Map<String, dynamic> params}) {
    return sailor.navigate<T>(route, params: params);
  }

  @override
  void pop() {
    // TODO: implement pop
  }
}

class Routes {
  static void createRoutes() {
    sailor.addRoute(SailorRoute(
      name: HomeBloc.route,
      builder: (context, args, params) {
        return HomeWidget();
      },
    ));
  }
}
