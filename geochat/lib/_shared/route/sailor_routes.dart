import 'package:geochat/_shared/route/sailor_navigator.dart';
import 'package:geochat/home/home_bloc.dart';
import 'package:geochat/home/widgets/home_widget.dart';
import 'package:sailor/sailor.dart';

class SailorRoutes {
  static void createRoutes() {
    sailor.addRoute(SailorRoute(
      name: HomeBloc.route,
      builder: (context, args, params) {
        return HomeWidget();
      },
    ));

    //TODO fazer
    sailor.addRoute(SailorRoute(
      name: "/addTask",
      builder: (context, args, params) {
        return null;
      },
    ));
  }
}
